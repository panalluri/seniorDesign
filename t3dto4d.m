function t3dto4d

for i = 1:27

    [filename,pathname]=uigetfile('*.dcm','Select Files', 'MultiSelect', 'on');
    
    Nz = length(filename);
    Ny = 0;
    Nx = 0;
    for k = 1:Nz
        imagedata = dicomread(fullfile(pathname,filename{k}));
        if k == 1
            [Ny,Nx] = size(imagedata);
            rawdata = zeros(Ny,Nx,Nz);
        end
        rawdata(:,:,k) = imagedata;                             % Convert to 3D
    end
    %four_d = zeros(Ny,Nx,Nz,27);
    four_d(:,:,:,i) = rawdata;                                  % Add to 4D matrix

end

%dicomwrite(four_d, "breast.dcm");
% Dimage = permute(rawdata,[1 2 4 3]);                        % Convert to 4D

for i = 1:27
    niftiwrite(four_d(:,:,:,i), i+".nii");
end

end