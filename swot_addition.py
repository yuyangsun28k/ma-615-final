import pandas as pd
import matplotlib.pyplot as plt

co2_data = pd.read_csv('data/co2.csv', skiprows=4)
fdi_data = pd.read_csv('data/fdi.csv', skiprows=4)
co2_long = co2_data.melt(id_vars=['Country Name', 'Country Code', 'Indicator Name', 'Indicator Code'], 
                         var_name='Year', value_name='CO2_Value')
fdi_long = fdi_data.melt(id_vars=['Country Name', 'Country Code', 'Indicator Name', 'Indicator Code'], 
                         var_name='Year', value_name='FDI_Value')

# Convert 'Year'
co2_long['Year'] = pd.to_numeric(co2_long['Year'], errors='coerce')
fdi_long['Year'] = pd.to_numeric(fdi_long['Year'], errors='coerce')

# Filter countries
countries = ['Bahamas, The', 'Dominica', 'Haiti']
co2_filtered = co2_long[co2_long['Country Name'].isin(countries)]
fdi_filtered = fdi_long[fdi_long['Country Name'].isin(countries)]

# Plotting CO2
plt.figure(figsize=(10, 6))
for country in countries:
    country_data = co2_filtered[co2_filtered['Country Name'] == country]
    plt.plot(country_data['Year'], country_data['CO2_Value'], label=country)

plt.title('CO2 Emissions over Years')
plt.xlabel('Year')
plt.ylabel('CO2 Emissions (kt)')
plt.legend()
plt.grid(True)
plt.tight_layout()
co2_plot_path = 'data/co2_emissions_plot.png'
plt.savefig(co2_plot_path)

# Plotting FDI
plt.figure(figsize=(10, 6))
for country in countries:
    country_data = fdi_filtered[fdi_filtered['Country Name'] == country]
    plt.plot(country_data['Year'], country_data['FDI_Value'], label=country)

plt.title('FDI Net Inflows over Years')
plt.xlabel('Year')
plt.ylabel('FDI Net Inflows (US$)')
plt.legend()
plt.grid(True)
plt.tight_layout()
fdi_plot_path = 'data/fdi_inflows_plot.png'

co2_plot_path, fdi_plot_path
