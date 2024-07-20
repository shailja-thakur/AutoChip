module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    reg [2:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b000; // initialize state to A
        else begin
            case (state)
                3'b000: begin // state A
                    if (x)
                        state <= 3'b001; // next state B
                    else
                        state <= 3'b000; // next state A
                end
                3'b001: begin // state B
                    if (x)
                        state <= 3'b100; // next state E
                    else
                        state <= 3'b001; // next state B
                end
                3'b010: begin // state C
                    if (x)
                        state <= 3'b001; // next state B
                    else
                        state <= 3'b010; // next state C
                end
                3'b011: begin // state D
                    if (x)
                        state <= 3'b010; // next state C
                    else
                        state <= 3'b001; // next state B
                end
                3'b100: begin // state E
                    if (x)
                        state <= 3'b100; // next state E
                    else
                        state <= 3'b011; // next state D
                end
                default: state <= 3'b000; // default to state A
            endcase
        end
    end
    
    always @(state) begin
        case (state)
            3'b011, 3'b100: z <= 1; // output high for state D or E
            default: z <= 0;
        endcase
    end
    
endmodule
