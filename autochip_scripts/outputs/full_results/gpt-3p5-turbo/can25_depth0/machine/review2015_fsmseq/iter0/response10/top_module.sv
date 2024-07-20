module top_module(
    input clk,
    input reset,
    input data,
    output start_shifting);

    reg [3:0] state;
    wire nextStateS;
    wire nextStateS1;
    wire nextStateS11;
    wire nextStateS110;
    wire nextStateDone;

    // Combinational logic block to determine next state
    assign nextStateS = (state == 4'b0000) ? data : 1'b0;
    assign nextStateS1 = (state == 4'b0001) ? data : 1'b0;
    assign nextStateS11 = (state == 4'b0010) ? data : 1'b0;
    assign nextStateS110 = (state == 4'b0011) ? ~data : 1'b0;
    assign nextStateDone = (state == 4'b0100) ? 1'b1 : 1'b0;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 4'b0000; // Initial state (S)
        end else begin
            case (state)
                4'b0000: state <= nextStateS;
                4'b0001: state <= nextStateS1;
                4'b0010: state <= nextStateS11;
                4'b0011: state <= nextStateS110;
                4'b0100: state <= nextStateDone;
                default: state <= 4'b0000; // Reset to initial state if no other cases match
            endcase
        end
    end

    // Output assignment
    assign start_shifting = (state == 4'b0100) ? 1'b1 : 1'b0;

endmodule
