- [layout](#layout)
  - [AspectRatio](#aspectratio)
  - [Box](#box)
  - [Center_Circle_Square](#center_circle_square)
  - [Container](#container)
  - [Flex](#flex)
  - [Grid](#grid)
  - [SimpleGrid](#simplegrid)
  - [Stack](#stack)
  - [Wrap](#wrap)
- [forms](#forms)
  - [Button](#button)
  - [IconButton](#iconbutton)
  - [Checkbox](#checkbox)
  - [Editable](#editable)
  - [FormControl](#formcontrol)
  - [Input](#input)
  - [NumberInput](#numberinput)
  - [PinInput](#pininput)
  - [radio](#radio)
  - [rangeSlider](#rangeslider)
  - [Select](#select)
  - [slider](#slider)
  - [Switch](#switch)
  - [Textarea](#textarea)
- [data_display](#data_display)
  - [Badge](#badge)
  - [CloseButton](#closebutton)
  - [Code](#code)
  - [Divider](#divider)
  - [Kbd](#kbd)
  - [List](#list)
  - [stat](#stat)
  - [table](#table)
  - [tag](#tag)
- [feedback](#feedback)
  - [Alert](#alert)
  - [CircularProgress](#circularprogress)
  - [Progress](#progress)
  - [skeleton](#skeleton)
  - [Spinner](#spinner)
  - [Toast](#toast)
- [Typography](#typography)
  - [Text](#text)
  - [Heading](#heading)
- [overlay](#overlay)
  - [AlertDialog](#alertdialog)
  - [Drawer](#drawer)
  - [Menu](#menu)
  - [Modal](#modal)
  - [Popover](#popover)
  - [Tooltip](#tooltip)
- [discloser](#discloser)
  - [Accordion](#accordion)
  - [tabs](#tabs)
  - [visually hidden](#visually-hidden)
- [Navigation](#navigation)
  - [breadcrumb](#breadcrumb)
  - [link](#link)
  - [linkOverlay](#linkoverlay)
- [media&icons](#mediaicons)
  - [avatar](#avatar)
  - [icon](#icon)
  - [image](#image)
- [others](#others)
  - [portal](#portal)
  - [transitions](#transitions)
- [hook](#hook)

# layout

## AspectRatio

```
    AspectRatio
```

```
        <AspectRatio ratio={Common values are:
                                            `21/9`,
                                            `16/9`,
                                            `9/16`,
                                            `4/3`,
                                            `1.85/1`
                                        }>
            <></>
        </AspectRatio>
```

## Box

```
    Box
```

```
        <Box></Box>
```

## Center_Circle_Square

```
  Center,Circle,Square
```

```
        <Center size="" >
        </Center>
        ---
        <Circle size="" >
        </Circle>
        ---
        <Square size="" >
        </Square>
```

## Container

```
  Container
```

```
        <Container centerContent colorScheme="" size="" variant="">
        </Container>
```

## Flex

```
  Flex,Spacer
```

```
        <Flex>
          <Spacer />
        </Flex>
```

## Grid

```
  Grid,GridItem
```

```
      <!--The children start at the beginning, the 1/3 mark and 2/3 mark -->
        <Grid
          templateColumns="1fr 1fr"     <!-- ____ -->
          autoColumns=""
          templateRows="repeat(3,1fr)"  <!--   |  -->
          autoRows=""
          gap={}
          area=""
          autoFlow=""
        >
            <GridItem

                colEnd=""
                colSpan="_"
                colStart=""
                rowEnd=""
                rowSpan="|"
                rowStart=""

            />
        </Grid>
```

## SimpleGrid

```
  SimpleGrid
```

```
        <SimpleGrid
            minChildWidth=""
            columns={[1,2,3]}
            spacing=""
            spacingX=""
            spacingY=""
        >

        </SimpleGrid>
```

## Stack

```
  Stack,HStack,VStack,StackDivider <!-- for fixed spacing-->
```

```
        <Stack
            divider={<StackDivider borderColor=""/>}
            align=""
            spacing=""
            direction=""
            justify=""
            wrap=""
            isInline
            shouldWrapChildren
          >
        </Stack>

        <HStack></HStack>
        <VStack></VStack>
```

## Wrap

```
  Wrap,WrapItem
```

```
        <Wrap
            align=""
            justify=""
            direction=""
            shouldWrapChildren
            spacing=""
        >
            <WrapItem>   </WrapItem>
        </Wrap>
```

# forms

## Button

```
    Button,ButtonGroup
```

```
        <ButtonGroup
          colorScheme=""
          variant=""
          spacing=""
          size=""
          isActive
          isDisabled
        >
            <Button
              colorScheme=""
              variant=""
              iconSpacing="" // space between icon and label.
              leftIcon=""
              rightIcon=""
              size=""
              isActive
              isDisabled
              isFullWidth // to its container
              isLoading
                spinner={< />}
                loadingText=""
                spinnerPlacement=""
            ></Button>
        </ButtonGroup>
```

## IconButton

```
    IconButton
```

```
    <IconButton
          icon={<AiFillHeart />}
          aria-label=""
          colorScheme="red"
          variant="solid"
          size='lg'

          isActive
          isDisabled
          isRound
          isLoading
            spinner={< />}
      />
```

## Checkbox

```
    Checkbox,ChekboxGroup
```

```
    <CheckboxGroup
        colorScheme=""
        variant=""
        defaultValue={["values of checkboxes"]}
        isDisabled
        size=""
        value=""
        onChange={()=>{}}

      >
        <Checkbox
            defaultIsChecked
            colorScheme=""
            variant=""
            size=""
            isDisabled
            isInvalid
            isReadOnly
            spacing="" //spacing btn' checkbox and label
            iconColor=""  // color of selection
            iconSize=""  // size of selection
            icon={< />}
            isIndeterminate
            value=""
            name =""
            onChange={()=>{}}
            onFocus={()=>{}}
        >
          display
        </Checkbox>
    </CheckboxGroup>
```

## Editable

```
  Editable,EditableInput,EditablePreview
```

```
    <Editable
        defaultValue="take this"
        placeholder=""
        value=""
        textAlign=""
        size=""
        colorScheme=""
        variant=""

        isDisabled
        isPreviewFocusable
        selectAllOnFocus
        startWithEditView
        submitOnBlur

        onCancel={()=>{}}
        onChange={()=>{}}
        onEdit={()=>{}}
        onSubmit={()=>{}}
      >
        <EditablePreview/>
        <EditableInput/>
      </Editable>
```

## FormControl

```
    FormControl,FormLabel,FormErrorMessage,FormHelperText
```

```
    <FormControl
        as="fieldset"
        isRequired
        isDisabled
        isInvalid
        isReadOnly

        size=""
        colorScheme=""
        variant="outline"
      >
        <FormLabel
          as="legend"
        >formlabel</FormLabel>

        <Input
            type=""
            placeholder=""
        />

        <FormHelperText>helpertext</FormHelperText>
      </FormControl>
```

## Input

```
    Input,InputGroup,InputLeftAddon,InputRightAddon
```

```
    <InputGroup>
        <InputLeftAddon
          children={</>  }
          color=""
          pointerEvents=""
        />

        <Input
          type=""
          placeholder=""
          name=""
          value=""
          size=""

          isDisabled
          isFullWidth
          isInvalid
          isReadOnly
          isRequired

          errorBorderColor="blue.300"
          focusBorderColor=""

          variant=""
        />

        <InputRightAddon children=""/>
      </InputGroup>
```

## NumberInput

```
  NumberInput
```

```
    <NumberInput
        name=""
        defaultValue={20}
        precision={2}
        min={10}
        max={30}
        step={1}

        clampValueOnBlur    //makes the number not more than max_num and not less then min_num
        allowMouseWheel
        isFullWidth
        isInvalid
        isReadOnly
        isRequired

        inputMode=""
        variant="flushed"
        errorBorderColor=""
        focusBorderColor=""
        size=""

        onChange={()=>{}}
        onFocus={()=>{}}

    >
        <NumberInputField
            //all input props
        />

        <NumberInputStepper
            //all felx props
        >

            <NumberIncrementStepper
                // Box,inputAddon props
            />
            <NumberDecrementStepper />

        </NumberInputStepper>

    </NumberInput>

```

## PinInput

```
    PinInput, PinInputField,HStack
```

```
    <HStack>
            <PinInput
                type=""
                defaultValue=""
                value=""
                size=""
                placeholder=""
                variant=""
                manageFocus=""

                autoFocus
                mask
                otp

                isDisabled
                isInvalid

                onChange={()=>{}}
                onComplete={()=>{}}
            >
                <PinInputField/>
            </PinInput>
      </HStack>
```

## radio

## rangeSlider

## Select

```
    Select
```

```
    <Select
      placeholder=""
      size=""
      variant=""
      icon={</>}   //icon of arrow sign
      iconColor=""

      isDisabled
      isInvalid
      isReadOnly
      isRequired

      errorBorderColor=""
      focusBorderColor=""
    >

      <option value="">1</option>

    </Select>
```

## slider

## Switch

```
    Switch
```

    <Switch
        name=""
        size=""
        colorScheme=""
        spacing=""

         defaultChecked
        defaultIsChecked

        onBlur={()=>{}} //runs when checkbox is blured(losses focus)
        onChange={()=>{}}
        onFocus={()=>{}}
    />

## Textarea

```
  Textarea
```

```
    <Textarea/>
```

# data_display

## Badge

```
  Badge
```

```
    <Badge
      colorScheme="green"
      variant="solid"
    >
      badgename
    </Badge>
```

## CloseButton

```
    CloseButton
```

```
    <CloseButton
        size=""
        colorScheme=""
        variant=""
        isDisabled
    />
```

## Code

```
  Code
```

```
    <Code
      colorScheme="red"
      variant="solid"
    >
      console.log("hi");
    </Code>
```

## Divider

```
  Divider
```

```
    <Divider
        orientation=""
        variant="dashed"
    />
```

## Kbd

```
    Kbd
```

```
    <Kbd> </Kbd>
```

## List

```
  List,ListItem,ListIcon,OrderedList,UnorderedList
```

```
    <List spacing={3}>

        <ListItem>
          <ListIcon as={AiFillHeart} color="green.500" />
          texts
        </ListItem>

        <UnorderedList>
          <ListItem>hi there</ListItem>
        </UnorderedList>

        <OrderedList>
          <ListItem>hi there</ListItem>
        </OrderedList>

    </List>
```

## stat

## table

## tag

# feedback

## Alert

```
  Alert,AlertIcon,AlertTitle,AlertDescription
```

```
    <Alert
      status=""
      variant=""
    >
      <AlertIcon />
      <AlertTitle></AlertTitle>
      <AlertDescription></AlertDescription>
    </Alert>
```

## CircularProgress

```
    CircularProgress, CircularProgressLabel
```

```
      <CircularProgress
          value={}
          size=""
          thickness=""
      >
            <CircularProgressLabel>
            </CircularProgressLabel>
      </CircularProgress>
```

## Progress

```
  Progress
```

```
      <Progress
        value={}
        max={}
        min={}
        h="10px"
        w="200px"
        isIndeterminate
        colorScheme="blue"
        hasStripe
        isAnimated
      />
```

## skeleton

```
    Skeleton, SkeletonCircle, SkeletonText
```

```
      <SkeletonCircle
          size=""
      />

      <Skeleton
        h=""
        w=""
        startColor=""
        endColor=""
        fadeDuration=""  //fadein duration in seconds
        speed=""         //speed in  "" seconds
        isLoaded     //this removes the occurane of skeleton
      ></Skeleton>

      <SkeletonText
          noOfLines={} spacing="" h="" w=""
      />
```

## Spinner

```
  Spinner
```

```
      <Spinner
          color=""
          emptyColor=""
          size=""
          thickness=""
          speed=""
      />
```

## Toast

```
    useToast
```

```
      const toast=useToast();   // must be before return()
      <Button
          onClick={()=>{
              toasuseToast t({
                position:"top | top-right | top-left | bottom | bottom-right | bottom-left",
                title:"title here",
                description:"description here",
                status:"success | error | warning | info",
                variant:"solid | subtile |left-accent | top-accent"
                duration:3000,
                isClosable:true,    //gives a close button with toast
                onCloseComplete: ()=>{}
                render:()=>(
                  //jsx toast tamplate
                )
              })
          }}

      >
        press
      </Button>
```

# Typography

## Text

```
  Text
```

```
    <Text
        fontSize=""
        isTruncated
        noOfLines={[1, 2, 3]}
        as =""
        align=""
        casing="" //css text-transform
        decoration=""
        orientation=""
      >
      </Text>
```

## Heading

```
    Heading
```

```

      <Heading
        as=""
        size=""
        fontSize=""
        isTruncated
        orientation=""
      >
      </Heading>
```

# overlay

## AlertDialog

```
  AlertDialog,AlertDialogOverlay,AlertDialogContent,AlertDialogHeader,AlertDialogBody,AlertDialogFooter
```

```
      import {useDisclouser} from '@chakra-ui/react
      const { isOpen, onOpen, onClose } = useDisclosure(); //before return
      <Button onClick={onOpen}>Open</Button>

      <AlertDialog
          isOpen={isOpen}
          onClose={ onClose }
          closeOnEsc="true"
          motionPreset=""
          size=""
          isCentered
          preserveScrollBarGap="true"
          onEsc={()=>{}}
      >
        <AlertDialogOverlay/>
        <AlertDialogContent>

            <AlertDialogHeader> Head </AlertDialogHeader>
            <AlertDialogBody> body </AlertDialogBody>
            <AlertDialogFooter
              onClick={onClose}
            > footer </AlertDialogFooter>

        </AlertDialogContent>

      </AlertDialog>
```

## Drawer

```
    Drawer,,DrawerOverlay,DrawerContent,DrawerHeader,DrawerBody,DrawerFooter
```

```
      import {useDisclouser} from '@chakra-ui/react
      const { isOpen, onOpen, onClose } = useDisclosure();
      <Button onClick={onOpen}>Open</Button>

      <Drawer
        isOpen={isOpen}
        onClose={onClose}
        placement="right"
        size="sm"
        allowPinchZoom
        blockScrollOnMount     // scrolling will be disabled on the body when the modal opens
        closeOnEsc
        closeOnOverlayClick
        isFullHeight
        onEsc={()=>{}}
        onOverlayClick={()=>{}}

      >
        <DrawerOverlay />
          <DrawerContent>
            <DrawerHeader> header </DrawerHeader>
            <DrawerBody> body</DrawerBody>
            <DrawerFooter onClick={onClose}> footer </DrawerFooter>
          </DrawerContent>
      </Drawer>
```

## Menu

```
    Menu,MenuButton,MenuList,MenuGroup,MenuItem,MenuOptionGroup,MenuItemOption,MenuCommand,MenuDivider
```

```
    <Menu
          closeOnSelect={true}
          closeOnBlur={true}
          placement=""
          preventOverflow={true}
      >
          <MenuButton
            as={Button}
            rightIcon={<AiOutlineArrowDown />}
            children="menu"
          />
          <MenuList>
                <MenuItem
                    command=""
                    commandSpacing=""
                    icon={}
                    isDisabled
                    isFocusable
                    children="a"
                />

                <MenuDivider />

                <MenuGroup title="">
                  <MenuItem/>
                </MenuGroup>

                <MenuDivider />

                <MenuOptionGroup
                  title="Options"
                  defaultValue="a"
                  type="checkbox"
                  value=""
                  onChange={()=>{}}
                >
                    <MenuItemOption
                      value="a"
                      children="a"
                      command=""
                      commandSpacing=""
                      icon={}
                      iconSpacing=""
                      isChecked
                      isDisabled
                      type="checkbox | Radio"
                    />
                </MenuOptionGroup>

                <MenuCommand children=""/>
          </MenuList>
      </Menu>
```

## Modal

```
  Modal,ModalOverlay,ModalContent,ModalHeader,ModalFooter,ModalBody,ModalCloseButton,
  useDisclosure
```

```
      const { isOpen, onOpen, onClose } = useDisclosure();
      <Button onClick={onOpen}>Open</Button>

      <Modal
        isOpen={isOpen}
        onClose={onClose}

        motionPreset=""
        scrollBehavior=""
        size=""

        isCentered
        blockScrollOnMount={}
        closeOnEsc={}
        closeOnOverlayClick={}

        onEsc={()=>{}}
        onOverlayClick={()=>{}}
      >
          <ModalOverlay />
          <ModalContent>
            <ModalHeader>
                <ModalCloseButton/>
            </ModalHeader>
            <ModalBody>  </ModalBody>
            <ModalFooter>  </ModalFooter>
          </ModalContent>
      </Modal>
```

## Popover

```
    Popover,PopoverTrigger,PopoverContent,PopoverHeader,PopoverBody,PopoverFooter,PopoverArrow,PopoverCloseButton,
```

```
      <Popover
          isOpen={}
          onOpen={}
          onClose={}

          placement=""
          trigger="hover" | "click"
          closeOnBlur={}
          arrowSize={}
          arrowShadowColor=""

          closeOnEsc={}
          closeOnBlur={}
          isLazy
          matchWidth

      >
          <PopoverTrigger>
            <Button> pop </Button>
          </PopoverTrigger>

          <PopoverContent>
              <PopoverArrow />
              <PopoverCloseButton />
              <PopoverHeader> head </PopoverHeader>
              <PopoverBody> body </PopoverBody>
              <PopoverFooter> footer </PopoverFooter>
          </PopoverContent>

      </Popover>
```

## Tooltip

```
  Tooltip
```

```
      <Tooltip
          label="you have hovered !"
            placement=""

            hasArrow
            isDisabled
            isOpen
            defaultIsOpen

            openDelay={}   //opens in milisec delay
            closeDelay={}  //closes in milisec delay
            arrowSize={}
          >
        hover meh ... hehe !
      </Tooltip>
```

# discloser

## Accordion

```
  Accordion,AccordionItem,AccordionButton,AccordionPanel,AccordionIcon,
```

```
    <Accordion
        allowMultiple
        allowToggle
        // defaultIndex={[, , ,]}
        // _expanded={{propert:"value",property:"value"}}
        onChange={()=>{}}
    >
      <AccordionItem
        // isDisabled
        // isFocusable
      >

        <AccordionButton
          // _expanded={{propert:"value",property:"value"}}
          // _disabled={{propert:"value",property:"value"}}
          // _hover={{propert:"value",property:"value"}}
        >
          <AccordionIcon />
        </AccordionButton>

        <AccordionPanel></AccordionPanel>

      </AccordionItem>

    </Accordion>
```

## tabs

## visually hidden

# Navigation

## breadcrumb

## link

## linkOverlay

# media&icons

## avatar

## icon

## image

# others

## portal

## transitions

# hook
