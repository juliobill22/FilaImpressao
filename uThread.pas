unit uThread;

interface

uses Classes, FMX.Dialogs, SyncObjs;

  type
    TImpressaoInThread = class(TThread)
      private
        FCriticalSection: TCriticalSection;
      public
        constructor Create(CreateSuspended: Boolean); overload;
        procedure Synchronize(AMethod: TThreadMethod); overload; inline;
        procedure Synchronize(AThreadProc: TThreadProcedure); overload; inline;
        class procedure Synchronize(const AThread: TThread; AMethod: TThreadMethod); overload; static;
        class procedure Synchronize(const AThread: TThread; AThreadProc: TThreadProcedure); overload; static;
      protected
        procedure Execute; override;
        procedure Resume; deprecated;
        procedure Start;
        procedure Suspend; deprecated;
        procedure Terminate;
      published
    end;

implementation

constructor TImpressaoInThread.Create(CreateSuspended: boolean);
begin
  inherited Create(CreateSuspended);
  Priority := tpIdle;
  FreeOnTerminate := CreateSuspended;
  FCriticalSection := TCriticalSection.Create;
end;

procedure TImpressaoInThread.Execute;
begin

end;

procedure TImpressaoInThread.Resume;
begin

end;

procedure TImpressaoInThread.Start;
begin

end;

procedure TImpressaoInThread.Suspend;
begin

end;

procedure TImpressaoInThread.Synchronize(AMethod: TThreadMethod);
begin

end;

procedure TImpressaoInThread.Synchronize(AThreadProc: TThreadProcedure);
begin

end;

class procedure TImpressaoInThread.Synchronize(const AThread: TThread;
  AMethod: TThreadMethod);
begin

end;

class procedure TImpressaoInThread.Synchronize(const AThread: TThread;
  AThreadProc: TThreadProcedure);
begin

end;

procedure TImpressaoInThread.Terminate;
begin

end;

end.
