#ifndef OBJECT_H
#define OBJECT_H

#define ENTITY_COUNT (0x4A0)
#define TEMPENTITY_START (ENTITY_COUNT - 0x80)
#define OBJECT_COUNT (0x100)

struct Entity {
    int XPos;
    int YPos;
    int values[21];
    int scale;
    int rotation;
    byte type;
    byte propertyValue;
    byte state;
    byte priority;
    byte drawOrder;
    byte direction;
    byte inkEffect;
    byte frame;
};

enum ObjectTypes {
    OBJ_TYPE_BLANKOBJECT = 0, //0 is always blank obj
    OBJ_TYPE_PLAYER = 1, //1 is always player obj
};

enum ObjectPriority {
    // The entity is active if the entity is on screen or within 128 pixels of the screen borders on any axis
    PRIORITY_BOUNDS,
    // The entity is always active, unless the stage state is PAUSED or FROZEN
    PRIORITY_ACTIVE,
    // Same as PRIORITY_ACTIVE, the entity even runs when the stage state is PAUSED or FROZEN
    PRIORITY_ALWAYS,
    // Same as PRIORITY_BOUNDS, however it only does checks on the x-axis, so when in bounds on the x-axis, the y position doesn't matter
    PRIORITY_XBOUNDS,
    // Same as PRIORITY_BOUNDS, however the entity's type will be set to BLANK OBJECT when it becomes inactive
    PRIORITY_BOUNDS_DESTROY,
    // Never Active.
    PRIORITY_INACTIVE,
};

extern int ObjectLoop;
extern int curObjectType;
extern Entity ObjectEntityList[ENTITY_COUNT];

extern char typeNames[OBJECT_COUNT][0x40];

extern int OBJECT_BORDER_X1;
extern int OBJECT_BORDER_X2;
extern const int OBJECT_BORDER_Y1;
extern const int OBJECT_BORDER_Y2;

void ProcessStartupScripts();
void ProcessObjects();

void SetObjectTypeName(const char *objectName, int objectID);

#endif // !OBJECT_H
