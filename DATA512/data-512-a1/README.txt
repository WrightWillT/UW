Purpose: Connect to the Wikimedia API to fetch pageview data and plot pageviews over time.  Ultimately this project is intended to complete the WEEK01 A1 assignment for the Fall 2019 DATA512 (Human-centered data science) course with a focus on reproducibility.

Reproducibility: In order to reproduce the results, simply run the 'hods-a1-data-curation' script in the src folder.  This script will automatically connect to the Wikimedia APIs, download raw data, clean it, and produce the final chart, saving the raw .JSON data and cleaned .csv in the labelled folders.

File Descriptions:

Within the 'data_raw' folder, there are 5 .json files, each pertaining to a single API call to Wikimedia's pageview data.  There is a legacy API with data from 2007-12 to 2016-08 where Wikimedia was not collecting user agent data and was therefore unable to differentiate user traffic from bot traffic; this data is referred to as 'page count' data. The modern API with the user agent differentiation started data collection 2015-07 to present; this data is referred to as 'pageviews' data and is subset to users only (no bots).  Additionally, traffic comes in the form of desktop and mobile, with the modern API distinguishing between mobile app and mobile web traffic.  These 3 differentiators (API source, traffic source, and date range) can be observed in the .json filenames. Data within these .json files are project data (e.g. 'en.wikipedia.org'), access data (e.g. 'desktop', 'mobile'), agent data (e.g. 'user' (only in the modern API calls)), granularity data (e.g. 'monthly'), and start and end timestamps (e.g. '2015070100').

Within the 'data_clean' folder, there is a single file containing the cleaned and joined data from the 'data_raw' folder.  Columns in this .csv are year (e.g. '2007'), month (e.g. '11'), pagecount_all_views (the summation of desktop and mobile legacy views), pagecount_desktop_views, pagecount_mobile_views, pageview_all_views (the summation of all desktop and mobile modern views), pageview_desktop_views, and pageview_mobile_views.  

Details regarding the transformations between the raw and clean data can be found within the 'src' folder's 'hcds-a1-data-curation.ipnyb' Jupiter notebook.  This file also produces the single .png file in the 'results' folder, which is a chart of pageviews for the English Wikipedia over time.

The API connection code was largely borrowed from 'http://paws-public.wmflabs.org/paws-public/User:Jtmorgan/data512_a1_example.ipynb'. 

Links to API documentation, including terms of use:
T&C: https://www.mediawiki.org/wiki/REST_API#Terms_and_conditions
Pageview API: https://wikitech.wikimedia.org/wiki/Analytics/AQS/Pageviews
Legacy Pagecount API: https://wikitech.wikimedia.org/wiki/Analytics/AQS/Legacy_Pagecounts
Endpoints: https://wikimedia.org/api/rest_v1/#/Pageviews%20data/get_metrics_pageviews_aggregate__project___access___agent___granularity___start___end_

