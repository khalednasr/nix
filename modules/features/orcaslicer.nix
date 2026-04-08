{
  den.aspects.orcaslicer.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages =
        let
          orca-slicer = pkgs.symlinkJoin {
            name = "orca-slicer";
            paths = [ pkgs.orca-slicer ];
            buildInputs = [ pkgs.makeWrapper ];
            postBuild = ''
              wrapProgram $out/bin/orca-slicer \
                --prefix LC_ALL : C \
                --prefix MESA_LOADER_DRIVER_OVERRIDE : zink \
                --prefix WEBKIT_DISABLE_DMABUF_RENDERER : 1 \
                --prefix __EGL_VENDOR_LIBRARY_FILENAMES : ${pkgs.mesa}/share/glvnd/egl_vendor.d/50_mesa.json \
                --prefix GALLIUM_DRIVER : zink
            '';
          };
        in
        [
          orca-slicer
        ];

      networking.firewall.allowedUDPPorts = [
        1900
        2021
      ];
    };
}
