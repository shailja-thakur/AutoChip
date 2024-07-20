module top_module(
    input clk,
    input reset,
    output shift_ena);

    // State register
    reg [2:0] state;
    
    // Clocked logic to update state
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b0;
        else begin
            case (state)
                3'b0: state <= 3'b1;
                3'b1: state <= 3'b2;
                3'b2: state <= 3'b3;
                3'b3: state <= 3'bDone;
                default: state <= 3'bDone;
            endcase
        end
    end
    
    // Combinational logic to determine shift_ena
    assign shift_ena = (state != 3'bDone) && (!reset);

endmodule
