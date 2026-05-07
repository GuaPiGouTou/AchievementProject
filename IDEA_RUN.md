# IDEA quick run

Open this folder in IntelliJ IDEA:

```text
/Users/frog/Documents/Playground 2/AchievementProject
```

Run configurations are available from the top-right run selector:

- `All - Frontend + Backend`: starts both services.
- `Backend - RuoYi`: starts the Spring Boot backend on `http://localhost:8080`.
- `Frontend - RuoYi UI`: starts the Vue UI on `http://localhost:8081`.
- `Stop - Old Backend Jar`: stops the old jar process currently occupying port `8080`.

Local environment choices:

- Project SDK: `1.8` / Amazon Corretto 8.
- Backend main class: `com.ruoyi.RuoYiApplication` in module `ruoyi-admin`.
- Frontend package: `RuoYi-Vue-master/ruoyi-ui/package.json`.
- Frontend script: `npm run dev:idea`, which fixes the dev-server port at `8081` and enables `NODE_OPTIONS=--openssl-legacy-provider`.

If IDEA shows a Maven import banner after opening the project, choose to load/import Maven projects.
