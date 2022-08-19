1. Install Cocoapods in your system
   
   --> If you have sudo access
      
      > sudo gem install cocoapods 
   --> Else
      > gem install cocoapods --user-install

2. Delete following files if available in project folder

   1. Final_PremSaiKrishna_kandagattla.workspace
   2. Pods ( Folder)
   3. podlock.file

3. If above files not availale then 

   -> open termina
   -> Navigate to the main folder of this project, example if project in downloads

      > cd Downloads/Final_PremSaiKrishna_Kandagattla

4. Run following command

   > pod install

5. Now all the files deleted in step 2 will be re-generated in the folder

6. Open Workspace and build, if build successful then run the Simulator

7. Allow location services within the application

8. If data not found for the current location give some desired locations data

   simulator -> features -> customer location
   latitude : 43.47
   longitude: -80.51

   Current Location should be Canada

9. Covid_data.json file already available in the project folder no need any extra file.

10. All Done for testing && End
  
