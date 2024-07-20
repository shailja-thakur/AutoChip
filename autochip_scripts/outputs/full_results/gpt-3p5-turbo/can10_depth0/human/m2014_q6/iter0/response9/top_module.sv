module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    reg [2:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b000;
        else
            case(state)
                3'b000: begin // A
                    if (w)
                        state <= 3'b000;
                    else
                        state <= 3'b001;
                end
                
                3'b001: begin // B
                    if (w)
                        state <= 3'b010;
                    else
                        state <= 3'b000;
                end
                
                3'b010: begin // C
                    if (w)
                        state <= 3'b011;
                    else
                        state <= 3'b100;
                end
                
                3'b011: begin // D
                    if (w)
                        state <= 3'b000;
                    else
                        state <= 3'b010;
                end
                
                3'b100: begin // E
                    if (w)
                        state <= 3'b100;
                    else
                        state <= 3'b011;
                end
                
                3'b101: begin // F
                    if (w)
                        state <= 3'b010;
                    else
                        state <= 3'b011;
                end
            endcase
        end
    end
    
    always @(state) begin
        case(state)
            3'b000: z <= 1'b0;
            3'b001: z <= 1'b0;
            3'b010: z <= 1'b0;
            3'b011: z <= 1'b0;
            3'b100: z <= 1'b1;
            3'b101: z <= 1'b1;
        endcase
    end
endmodule
