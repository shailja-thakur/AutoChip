module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output done
);
    reg [2:0] state;
    reg done_reg;
    reg [2:0] count;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            done_reg <= 0;
            count <= 0;
        end else begin
            case (state)
                0: begin
                    if (in[3] == 1) begin
                        state <= 1;
                        count <= count + 1;
                    end
                end
                1: begin
                    if (count < 2) begin
                        state <= 1;
                        count <= count + 1;
                    end else begin
                        state <= 2;
                    end
                end
                2: begin
                    state <= 0;
                    done_reg <= 1;
                    count <= 0;
                end
            endcase
        end
    end
    
    assign done = done_reg;
    
endmodule
