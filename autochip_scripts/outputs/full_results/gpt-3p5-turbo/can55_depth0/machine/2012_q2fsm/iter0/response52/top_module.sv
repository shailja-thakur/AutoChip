module top_module (
    input clk,
    input reset,
    input w,
    output z
);
    
    reg [2:0] state; // state register
    
    always @(posedge clk or posedge reset) begin
        if(reset) // synchronous reset
            state <= 3'b000; // initial state is A
        else begin
            case(state)
                3'b000: begin // state A
                    if(w)
                        state <= 3'b001; // transition to state B
                    else
                        state <= 3'b000; // transition to state A
                end
                3'b001: begin // state B
                    if(w)
                        state <= 3'b010; // transition to state C
                    else
                        state <= 3'b010; // transition to state D
                end
                3'b010: begin // state C
                    if(w)
                        state <= 3'b100; // transition to state E
                    else
                        state <= 3'b010; // transition to state C
                end
                3'b011: begin // state D
                    if(w)
                        state <= 3'b111; // transition to state F
                    else
                        state <= 3'b000; // transition to state A
                end
                3'b100: begin // state E
                    if(w)
                        state <= 3'b100; // transition to state E
                    else
                        state <= 3'b010; // transition to state C
                end
                3'b101: begin // state F
                    if(w)
                        state <= 3'b010; // transition to state C
                    else
                        state <= 3'b101; // transition to state F
                end
                default: state <= 3'b000; // default case, transition to state A
            endcase
        end
    end
    
    assign z = (state == 3'b100) || (state == 3'b101); // output z is 1 when state is E or F

endmodule
