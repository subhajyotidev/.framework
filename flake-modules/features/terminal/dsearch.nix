{ inputs, ... }:

{
  flake.modules.homeManager.dsearch = { pkgs, ... }: {
    imports = [
      inputs.dsearch.homeModules.dsearch
    ];
    programs.dsearch = {
      enable = true;

      # Use a custom package (optional)
      package = pkgs.dsearch;

      # Custom configuration (TOML format)
      config = {
        # Server configuration
        listen_addr = ":43654";

        # Index settings
        index_path = "~/.cache/dsearch/index";
        max_file_bytes = 2097152; # 2MB
        worker_count = 4;
        index_all_files = true;

        # Auto-reindex settings
        auto_reindex = false;
        reindex_interval_hours = 24;

        # Text file extensions
        text_extensions = [
          ".txt"
          ".md"
          ".go"
          ".py"
          ".js"
          ".ts"
          ".jsx"
          ".tsx"
          ".json"
          ".yaml"
          ".yml"
          ".toml"
          ".html"
          ".css"
          ".rs"
        ];

        # Index paths configuration
        index_paths = [
          {
            path = "~/Documents";
            max_depth = 6;
            exclude_hidden = true;
            exclude_dirs = [
              "node_modules"
              "venv"
              "target"
            ];
          }
          {
            path = "~/Projects";
            max_depth = 8;
            exclude_hidden = true;
            exclude_dirs = [
              "node_modules"
              ".git"
              "target"
              "dist"
            ];
          }
        ];
      };
    };
  };
}
