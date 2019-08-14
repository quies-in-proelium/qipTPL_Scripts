//////////////////////////////////////////////////////////
// Aufruf in der init Zeile des Objekts mit
//
// [this] call qipTPL\Scripts\intel_example.sqf
//

params ["_object"];

if ( hasInterface ) then {
    _object addAction [
        ////////////////////////////////////////////////////////////////////////
        // Eigener Mousradtext
        "Tagebuch aufheben",
        {[_object,"action"] spawn BIS_fnc_initIntelObject;},
        [],
        10,
        true,
        true,
        "",
        "isplayer _this && {_this distance _target < 2} &&
        {(side group _this) in (_target getvariable ['RscAttributeOwners',[west,east,resistance,civilian]])}"
    ];
};

if (isServer) then {
    _object setVariable [
        "RscAttributeDiaryRecord_texture",
        ////////////////////////////////////////////////////////////////////////
        // Angehängtes Bild
        "",
        true
    ];

    [_object, "RscAttributeDiaryRecord", [
        ////////////////////////////////////////////////////////////////////////
        // Titel (Menüeintrag)
        "Tagebuch",
        ////////////////////////////////////////////////////////////////////////
        // Beschreibung (Haupttext)
        // Kann formtiert werden, unterstützte Formatierungen
        // https://community.bistudio.com/wiki/createDiaryRecord
        "01.01.2020<br /><br />Ich hab immer noch nen Kater"
    ]] call BIS_fnc_setServerVariable;

    ////////////////////////////////////////////////////////////////////////////
    //  Tagebuch eintrag wird mit dem eigentragnen Empfänger (recipiant) geteilt
    //  in diesem Beispiel mit allen der Seite west weitere Werte wie folgt:
    //
    //  Object  - the function will be executed only where unit is local [default: everyone]
    //  String  - the function will be executed only where object or group defined
    //            by the variable with passed name is local
    //  Boolean - true to execute on each machine (including the one where the
    //            function was called from), false to execute it on server only
    //  Number  - function will be executed only on client with the given owner ID
    //  Side    - function will be executed only on clients where the player is
    //            on the specified side
    //  Group   - function will be executed only on clients where the player is
    //            in the specified group
    //  Array   - array of targets of types listed above
    _object setVariable ["recipients", west, true];

    ////////////////////////////////////////////////////////////////////////////
    // Seite(n) die die mit dem Intelobject interagieren können
    _object setVariable ["RscAttributeOwners", [west], true];
};
