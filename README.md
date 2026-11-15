A permanent lunar outpost is the next ambition of human exploration, but the Moon is a harsh environment, and planning a mission there means weighing many factors at once. To make this easier, we created Regolith Finder, an interactive Moon map designed to help analyze, evaluate, and select potential landing sites for lunar exploration, particularly for NASA’s Artemis program.

Users can explore the lunar surface, compare different landing locations, and access scientific and geographical data provided by NASA to better understand what each site offers. Beyond the predefined locations, users can also pick any point on the Moon themselves. By selecting a spot directly on the map, they can retrieve the available scientific and geographical information for that area and use it as their own landing site. This gives them the freedom to investigate places outside NASA’s existing candidate regions.

1- What does Regolith Finder do ?

Our project, entitled Lunar Landing Site Navigator, is an interactive web application designed to assist in the planning and study of future lunar exploration missions and the establishment of lunar bases. The site is based on an interactive lunar globe on which users can view, activate and compare various features of the lunar surface and environment in order to identify the areas best suited to the development of a base. 

We have grouped the key parameters for site selection into several categories: 

Natural resources: the potential presence of water ice, as well as iron, titanium, aluminium and silicon, which are useful for producing vital resources and manufacturing the components needed to build a base. 
Topography: altitude, slope and terrain characteristics, which influence accessibility and development potential. 
Lunar environment: temperature, duration of sunlight, intensity of solar radiation, shaded areas and radiation levels. 
Communication with Earth: possibilities for communication with ground stations, taking into account the movements and rotation of celestial bodies as well as the visibility of Earth from the Moon. This information enables us to identify the periods during which direct communication with Earth is geometrically possible. 
Users can select the characteristics they wish to examine using tick boxes and sliders. Each selection activates a coloured visualisation layer on the globe, accompanied by its legend. This allows users to visualise and cross-reference different parameters in order to compare potential sites and gain a better understanding of their advantages and constraints.

2- What benefits does it have ?

Lunar Landing Site Navigator offers several benefits for the preparation and planning of future lunar missions. 

First, it centralizes a wide range of lunar scientific data provided by NASA within a single interactive platform. This avoids having to consult numerous separate scientific maps and datasets. 

Second, it makes complex lunar information easier to understand through an interactive 3D globe and customizable visual layers, allowing users to visualize and combine different environmental and geological parameters. 

Third, users can select a specific location on the Moon to explore its characteristics, including its surface composition and the location of nearby useful resources, such as water ice and areas with favorable sunlight conditions. 

Finally, the platform allows users to compare several potential landings or settlement sites. They can define their own evaluation criteria and assign a score to each one, allowing the application to assess and rank locations according to the priorities of their mission. 

This flexibility makes the tool useful for exploring different settlement strategies and identifying locations that best match specific mission requirements. 

3- What is the intended impact of the project ?

Our project has two main objectives. 

Firstly, Regolith Finder aims to simplify the preparation of future lunar exploration and settlement missions, particularly when identifying and comparing potential areas for development. By bringing together various scientific datasets in one interactive platform, it helps users understand the advantages and constraints of different locations. It could also facilitate decision-making and the assessment of alternative sites when mission requirements change, including during late planning stages. The platform is not intended to replace existing specialized scientific software or high-precision site selection tools. Instead, it provides a complementary interface that makes information easier to access, interpret, and compare. 

Secondly, it attends to make lunar science accessible to everyone. The objective is educational and recreational. We want the platform to be accessible not only to professionals, but also to teachers, students, educational projects, and space enthusiasts. By combining scientific data with an interactive globe and customizable visualizations, the project offers an opportunity to explore the Moon, understand the challenges of lunar settlement, and experiment with different site selection criteria. 

We hope to make lunar exploration more understandable and engaging, while encouraging curiosity, scientific learning, and interest in future space missions. 


 4- What tools, coding languages, hardware, or software did you use?

The project was developed using HTML, CSS, Python and JavaScript, which form the foundation of the website's interface and interactive features.

We also integrated a 3D model of the Moon in STL format, which serves as the basis for the interactive three-dimensional globe and allows users to explore lunar locations and visualize different scientific data layers.

The scientific data used in the application come from various institutional sources, including NASA, the Jet Propulsion Laboratory (JPL), the Canadian Space Agency (CSA) and the United States Geological Survey (USGS). We also relied on specialized lunar mapping and visualization tools to collect, explore and integrate the data into our platform.

The project will be hosted on GitHub, providing access to the website's source code and making the project available online. A complete list of the data sources and references is provided at the end of the project submission.

5- How is your project creative ?

The creativity of Rigolith Finder lies in its combination of an intuitive interface, interactive features, and scientific information within a single platform.  Rather than simply displaying lunar maps, our project offers an interactive 3D environment where users can activate different data layers, explore specific locations, and compare multiple potential sites. 

One of its key features is the ability to evaluate and compare lunar locations according to user-defined criteria, allowing different mission priorities and development strategies to be explored. Another aspect of its originality is its dual purpose: the platform is designed to be useful for professionals involved in lunar mission planning while remaining accessible and engaging for students, teachers and space enthusiasts. 

By bringing together technical information and an accessible user experience, we aim to bridge the gap between specialized scientific tools and public lunar exploration resources.

6 - What factors did your team consider ?

Several important factors were considered throughout the development of our project.

Scientific reliability: We prioritized data from recognized institutional sources, particularly NASA and other space and geological agencies, to ensure that the information displayed is based on credible scientific resources.
Mission requirements: We identified the main factors influencing the selection of a potential lunar settlement site, including natural resources, topography, environmental conditions and communication possibilities with Earth.
Usability: We aimed to create an intuitive interface that makes complex scientific information understandable and easy to explore.
Flexibility: Users can choose their own evaluation criteria and priorities, allowing the platform to adapt to different mission scenarios and objectives.
Accessibility: We wanted the application to be useful to both professionals and a wider audience, including students, teachers and space enthusiasts.
Technical constraints: One of our main challenges was integrating scientific datasets from different sources into our website. We also had to adapt existing lunar data maps, such as minimum temperature maps, to our 3D lunar model. Differences in scale, resolution and map projections made this integration particularly challenging.
These challenges required us to consider not only the scientific relevance of the data, but also how to process, adapt and display it accurately within a unified interactive environment.

## Download and run

On GitHub, select **Code > Download ZIP** and extract the archive. GitHub puts the complete project, including its data, in a repository-named folder. From that folder, double-click `LANCER.bat` on Windows or run `./lancer.sh` on macOS/Linux.

## Run online or publish your own copy

After GitHub Pages is enabled, the site is available at [https://oiassix.github.io/regolith-finder/](https://oiassix.github.io/regolith-finder/) without manually downloading the project. See [the deployment guide](./docs/DEPLOYMENT.md) to enable Pages, publish a fork without a local clone, or launch locally. The static Pages version does not provide server-only features such as live JPL Horizons requests.
