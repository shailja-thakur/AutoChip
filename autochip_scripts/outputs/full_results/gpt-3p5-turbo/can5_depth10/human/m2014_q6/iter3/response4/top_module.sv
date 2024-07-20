module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    reg [2:0] state;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
        end
        else begin
            case (state)
                3'b000: begin // A
                    if (w)
                        state <= 3'b001; // Go to B
                    else
                        state <= 3'b000; // Stay in A
                end
                
                3'b001: begin // B
                    if (w)
                        state <= 3'b010; // Go to C
                    else
                        state <= 3'b011; // Go to D
                end
                
                3'b010: begin // C
                    if (w)
                        state <= 3'b101; // Go to F
                    else
                        state <= 3'b110; // Go to E
                end
                
                3'b011: begin // D
                    if (w)
                        state <= 3'b110; // Go to E
                    else
                        state <= 3'b000; // Go to A
                end
                
                3'b100: begin // E
                    if (w)
                        state <= 3'b100; // Stay in E
                    else
                        state <= 3'b011; // Go to D
                end
                
                3'b101: begin // F
                    if (w)
                        state <= 3'b010; // Go to C
                    else
                        state <= 3'b011; // Go to D
                end
                
                default: state <= 3'b000; // Default state is A
            endcase
        end
    end

    always @(posedge clk) begin
        if (state == 3'b101 || state == 3'b100)
            z <= 1;
        else
            z <= 0;
    end

endmodule
