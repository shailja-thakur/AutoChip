module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    reg [2:0] state;
    
    always @(posedge clk or negedge reset) begin
        if (reset)
            state <= 3'b0; // initialize state to A
        else begin
            case (state)
                3'b000: begin // state A
                    if (x)
                        state <= 3'b001; // transition to B
                    else
                        state <= 3'b000; // remain in A
                end
                3'b001: begin // state B
                    if (x)
                        state <= 3'b100; // transition to E
                    else
                        state <= 3'b001; // remain in B
                end
                3'b010: begin // state C
                    if (x)
                        state <= 3'b001; // transition to B
                    else
                        state <= 3'b010; // remain in C
                end
                3'b011: begin // state D
                    if (x)
                        state <= 3'b010; // transition to C
                    else
                        state <= 3'b001; // remain in B
                end
                3'b100: begin // state E
                    if (x)
                        state <= 3'b100; // remain in E
                    else
                        state <= 3'b011; // transition to D
                end
                default: 
                    state <= 3'b0; // default to state A
            endcase
        end
    end
    
    // assign output z high when state is D or E
    always @(state) begin
        case (state)
            3'b011, 3'b100:
                z <= 1'b1; // output high
            default:
                z <= 1'b0; // output low
        endcase
    end

endmodule
