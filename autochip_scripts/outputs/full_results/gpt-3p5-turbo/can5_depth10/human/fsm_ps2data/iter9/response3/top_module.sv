module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);
    reg [1:0] state;
    reg [2:0] counter;
    reg [7:0] byte1;
    reg [7:0] byte2;
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 2'b00;
            counter <= 3'b000;
            byte1 <= 8'h00;
            byte2 <= 8'h00;
            done <= 0;
            out_bytes <= 0;
        end
        else begin
            case (state)
                2'b00: begin
                    if (in[3]) begin
                        state <= 2'b01;
                        byte1 <= in;
                        counter <= 3'b001;
                    end
                end
                2'b01: begin
                    if (counter == 3'b010) begin
                        state <= 2'b10;
                        byte2 <= in;
                        out_bytes <= {byte2, byte1};
                        done <= 1;
                    end
                    else if (byte1 != 8'h00) begin
                        byte2 <= byte1;
                        byte1 <= in;
                        counter <= counter + 1;
                    end
                end
                2'b10: begin
                    state <= 2'b00;
                    counter <= 3'b000;
                    byte1 <= 8'h00;
                    byte2 <= 8'h00;
                    done <= 0;
                    out_bytes <= 0;
                end
            endcase
        end
    end
    
endmodule
