//
//  CigarTableViewController.m
//  CigarNotes
//
//  Created by Nick Newberg on 7/31/14.
//  Copyright (c) 2014 Nick Newberg. All rights reserved.
//

#import "CigarTableViewController.h"
#import "CigarNoteData.h"
#import "TextFieldTableViewCell.h"
#import "CigarNoteViewController.h"

@interface CigarTableViewController ()

@property int currentTextFieldIndex;
@property (strong, nonatomic) CigarNoteData *cigarChosen;
@property BOOL isEditingTextField;
@end

@implementation CigarTableViewController

@synthesize mainColor, detailColor, cigars, currentTextFieldIndex, isEditingTextField, cigarChosen;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        // Initializa/Load Cigars From Persistent Archive
        [self loadCigars];
    }
    
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];

    //Define Color Scheme Colors
    self.mainColor = [UIColor colorWithRed:228.0/255 green:223.0/255 blue:213.0/255 alpha:100];
    self.detailColor = [UIColor colorWithRed:83.0/255 green:108.0/255 blue:133.0/255 alpha:100];
    
    //Set Navigation Bar Colors
    self.navigationController.navigationBar.barTintColor = self.detailColor;
    self.navigationController.navigationBar.tintColor = self.mainColor;
    
    //Set Navigation Bar Back Button Style
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                 style:UIBarButtonItemStyleBordered
                                                                target:nil
                                                                action:nil];
    
    [self.navigationItem setBackBarButtonItem:backItem];
    
    //Set Edit Button and Font
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont fontWithName:@"Futura" size:17.0], NSFontAttributeName,
                                        self.mainColor, NSForegroundColorAttributeName,
                                        nil] 
                              forState:UIControlStateNormal];

    //Set Background Color
    self.tableView.backgroundColor = self.mainColor;
    
    //Register Custom Cell Class For Table View
    [self.tableView registerClass:[TextFieldTableViewCell class] forCellReuseIdentifier: @"Cell"];

    //Set Table View Delegate
    self.tableView.delegate = self;
    
    self.isEditingTextField = NO;
    
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return cigars.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    TextFieldTableViewCell *cell = (TextFieldTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    
    
    // Configure the cell...
    CigarNoteData *currentCigar = [cigars objectAtIndex: indexPath.row];
    cell.theTextField.text = currentCigar.cigarName;
    cell.theTextField.font = [UIFont fontWithName:@"Futura" size: 15 ];
    cell.theTextField.textColor = detailColor;
    cell.theTextField.delegate = self;
    
    UILabel *accessoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    accessoryLabel.text = [NSString stringWithFormat:@"%d", currentCigar.cigarCount];
    accessoryLabel.font = cell.theTextField.font;
    accessoryLabel.textColor = detailColor;
    cell.accessoryView = accessoryLabel;
    
    return cell;
}

//If Tap TableView Cell NOT TextField in the Cell, Segue

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[self.tableView cellForRowAtIndexPath: indexPath] setSelected:YES] ;
    
    self.cigarChosen = [self.cigars objectAtIndex: indexPath.row];
    
    [self performSegueWithIdentifier: @"HumidorToNote" sender:self];
    
    [[self.tableView cellForRowAtIndexPath: indexPath] setSelected:NO] ;

}



//Adding New Cigar With "+" Button
- (IBAction)plusAddCigar:(id)sender {
    
    CigarNoteData * blankCigar = [[CigarNoteData alloc] initWithName: @""];
    
    [self.cigars insertObject: blankCigar atIndex: 0];
    
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths: [NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView endUpdates];
    
    TextFieldTableViewCell *newCell = (TextFieldTableViewCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    self.isEditingTextField = YES;
    [newCell.theTextField becomeFirstResponder];
    
                                       
    
}


//Editing (Deleting) Cells
- (void) tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle) editing forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if( editing == UITableViewCellEditingStyleDelete ) {
        
        [cigars removeObjectAtIndex:indexPath.row];
        
        [tv deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                  withRowAnimation:UITableViewRowAnimationLeft];
        
        [self saveCigars];
    }
}

//Trigger Editing Mode
- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    
    [super setEditing:editing animated:animated];
    
    
    self.isEditingTextField = !self.isEditingTextField;
}

//Allow All Rows to Be Moved By Edit
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//Perform Moving of cell and updating Data Accordingly
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    CigarNoteData *cigarToMove = self.cigars[sourceIndexPath.row];
    [self.cigars removeObjectAtIndex:sourceIndexPath.row];
    [self.cigars insertObject:cigarToMove atIndex:destinationIndexPath.row];
    [self saveCigars];
}

    

/////////////////Text Field Delegate Methods ///////////////////////////

//Allow Editing of Text Field Cell Only During Edit Mode
//And Calculate Current Text Field Index
//AND Trigger Segues as If "Cell Selected"
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    int i;
    
    for (i = 0; i < self.cigars.count; i++)
    {
        CigarNoteData *currentCigar = (CigarNoteData *)[cigars objectAtIndex: i];
        
        if ( [currentCigar.cigarName isEqualToString: textField.text])
        {
            self.currentTextFieldIndex = i;
            break;
        }
        
    }
    
    if (self.isEditingTextField == NO)
    {
        
        [[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow: self.currentTextFieldIndex inSection:0]] setSelected:YES] ;
        
        self.cigarChosen = [self.cigars objectAtIndex:self.currentTextFieldIndex];
        
        [self performSegueWithIdentifier: @"HumidorToNote" sender:self];
        
        [[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow: self.currentTextFieldIndex inSection:0]] setSelected:NO] ;
        
        
    }
    
    return self.isEditingTextField;
    
}


//Handles The Return On Text Field and Editing of Cigar Data
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
        [self handleNewCigarReturn:textField];

        [textField resignFirstResponder];
        self.isEditingTextField = NO;
        
        return YES;
    }
    
-(void) handleNewCigarReturn:(UITextField *)textField{
        
        CigarNoteData *cigarWithNewName = (CigarNoteData *)[cigars objectAtIndex:self.currentTextFieldIndex];
        
        cigarWithNewName.cigarName = textField.text;
        
        [self saveCigars];
    
    }


//////////////// End of Text Field Delegate Methods /////////////////////


/////////////// Cigar Saving, Loading and Data Persistence Methods //////////

- (NSString *)pathForCigars {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths lastObject];
    
    return [documents stringByAppendingPathComponent:@"cigars.plist"];
}

- (void)loadCigars{
    
    NSString *filePath = [self pathForCigars];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
        self.cigars = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    }
    
    else {
        
        self.cigars = [NSMutableArray array];
        
    }
    
}

- (void)saveCigars {
    NSString *filePath = [self pathForCigars];
    [NSKeyedArchiver archiveRootObject:self.cigars toFile:filePath];
}

/////////////// End of Data Persistence Methods ///////////////////////////////


//Preparing New Note VC for Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    if ([segue.identifier isEqualToString: @"HumidorToNote"]){
        
        CigarNoteViewController *destinationVC = segue.destinationViewController;
        destinationVC.cigarNoteData = self.cigarChosen;
        destinationVC.mainColor = self.mainColor;
        destinationVC.detailColor = self.detailColor;
        
    }
    
}

//Save Data, Go Back to Updated Humidor Table View
- (IBAction)unwindToHumidor:(UIStoryboardSegue *)segue;{
    
    if ([segue.sourceViewController isKindOfClass: [CigarNoteViewController class]])
    {
        CigarNoteViewController *source = [segue sourceViewController];
        CigarNoteData *newCigar = source.cigarNoteData;
        
        if (newCigar)
        {
            int i;
            for (i = 0 ; i < (self.cigars.count); i++)
            {
                CigarNoteData *aCigar = [self.cigars objectAtIndex:i];
                if ([aCigar.cigarName isEqualToString: newCigar.cigarName])
                {
                    [self.cigars removeObjectAtIndex: i];
                    
                    if (newCigar.cigarCount > 0){
                        [self.cigars insertObject:newCigar atIndex:i];
                    }
                    else{
                        [self.cigars insertObject:newCigar atIndex: self.cigars.count];
                    }
                    break;
                }
            }
            
            
            [self.tableView reloadData];
            [self saveCigars];
        }
    }

    
}


@end
