function [labeledImage, numSegments] = mysegmentation(pic1)
    [row, column] = find(pic1 == 1);
    POINTS = [row'; column'];
    current_obj_num = 1;
    POINTS_NUM = size(POINTS, 2);

    while POINTS_NUM > 0
        point_ini = POINTS(:, 1);
        POINTS(:, 1) = [];
        [POINTS, newpoints] = close_points(point_ini, POINTS);
        current_obj = [point_ini newpoints];
        newpoints_len = size(newpoints, 2);

        while newpoints_len > 0
            newpoints2 = [];
            for i = 1:newpoints_len
                [POINTS, newpoints1] = close_points(newpoints(:, i), POINTS);
                newpoints2 = [newpoints2 newpoints1];
            end
            current_obj = [current_obj newpoints2];
            newpoints = newpoints2;
            newpoints_len = size(newpoints, 2);
        end

        OBJECT{current_obj_num} = current_obj;
        current_obj_num = current_obj_num + 1;
        POINTS_NUM = size(POINTS, 2);
    end

    z = 1;
    current_obj_num = current_obj_num - 1;
    for i = 1:current_obj_num
        if size(OBJECT{i}, 2) > 0
            OBJECT_NEW{z} = OBJECT{i};
            z = z + 1;
        end
    end

    labeledImage = zeros(size(pic1));
    for i = 1:numel(OBJECT_NEW)
        ind = sub2ind(size(pic1), OBJECT_NEW{i}(1, :), OBJECT_NEW{i}(2, :));
        labeledImage(ind) = i;
    end

    numSegments = numel(OBJECT_NEW);
end

function [POINTS, newpoints] = close_points(point_ini, POINTS)
    POINTS_NUM = size(POINTS, 2);
    diff = abs(repmat(point_ini, 1, POINTS_NUM) - POINTS);
    index = find(diff(1, :) <= 1 & diff(2, :) <= 1);
    newpoints = POINTS(:, index);
    POINTS(:, index) = [];
end
