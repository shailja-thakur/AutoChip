module top_module (
    input clk,
    input reset,
    input w,
    output z
);
    reg [2:0] state;
    
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            state <= 3'b000;   // Initialize state to A
        else
        begin
            case (state)
                3'b000:    // state A
                    if (w)
                        state <= 3'b000;
                    else
                        state <= 3'b001;
                3'b001:    // state B
                    if (w)
                        state <= 3'b011;
                    else
                        state <= 3'b010;
                3'b010:    // state C
                    if (w)
                        state <= 3'b100;
                    else
                        state <= 3'b010;
                3'b011:    // state D
                    if (w)
                        state <= 3'b001;
                    else
                        state <= 3'b110;
                3'b100:    // state E
                    if (w)
                        state <= 3'b100;
                    else
                        state <= 3'b110;
                3'b101:    // state F
                    if (w)
                        state <= 3'b100;
                    else
                        state <= 3'b101;
                default:
                    state <= 3'b000;
            endcase
        end
    end
    
    assign z = (state == 3'b101);
    
endmodule
