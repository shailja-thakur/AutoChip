module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);
    
    reg [2:0] state;
    reg [5:0] count;
    wire [6:0] flag_pattern;
    
    assign flag_pattern = 7'b0111111;
    assign flag = (count == 6'b0111110);
    assign disc = (count == 5'b011111);
    assign err = (count >= flag_pattern) & ~flag;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
            count <= 0;
        end else begin
            case (state)
                3'b000:
                    if (in == 1'b1) begin
                        state <= 3'b001;
                        count <= 1;
                    end
                3'b001:
                    if (in == 1'b1) begin
                        if (count == flag_pattern) begin
                            state <= 3'b010;
                            count <= 1;
                        end else if (count == 5'b011111) begin
                            state <= 3'b001;
                            count <= 5'b100000;
                        end else begin
                            state <= 3'b001;
                            count <= count + 1;
                        end
                    end else begin
                        state <= 3'b000;
                        count <= 0;
                    end
                3'b010:
                    if (in == 1'b1) begin
                        state <= 3'b010;
                        count <= count + 1;
                    end else begin
                        state <= 3'b011;
                        count <= 1;
                    end
                3'b011:
                    if (in == 1'b1) begin
                        state <= 3'b011;
                        count <= count + 1;
                    end else begin
                        state <= 3'b010;
                    end
            endcase
        end
    end
    
endmodule
