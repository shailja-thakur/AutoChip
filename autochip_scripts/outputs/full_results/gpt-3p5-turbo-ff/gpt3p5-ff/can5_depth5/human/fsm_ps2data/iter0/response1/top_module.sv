module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

reg [7:0] state;
reg [7:0] in_reg;
reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;
reg [23:0] out_bytes_reg;

always @(posedge clk) begin
    if (reset) begin
        state <= 0;
        in_reg <= 0;
        byte1 <= 0;
        byte2 <= 0;
        byte3 <= 0;
        out_bytes_reg <= 0;
        done <= 0;
    end else begin
        case (state)
            0: begin
                in_reg <= in;
                if (in[3]) begin
                    byte1 <= in_reg;
                    state <= 1;
                end
            end
            1: begin
                in_reg <= in;
                if (in[3]) begin
                    byte1 <= in_reg;
                    byte2 <= 0;
                    byte3 <= 0;
                    state <= 1;
                end else if (!in[3]) begin
                    byte2 <= in_reg;
                    state <= 2; 
                end
            end
            2: begin
            	in_reg <= in;
                if (in[3]) begin
                    byte1 <= in_reg;
                    byte2 <= 0;
                    byte3 <= 0;
                    state <= 1;
                end else if (!in[3]) begin
                    byte2 <= in_reg;
                    if (byte2[3]) begin
                        byte3 <= in_reg;
                        state <= 3;
                        out_bytes_reg <= {byte1, byte2, byte3};
                        done <= 1;
                    end else begin
                        byte1 <= byte2;
                        byte2 <= in_reg;
                        state <= 2; 
                    end
                end
            end
            3: begin
                if (in[3]) begin
                    state <= 1;
                end else if (!in[3]) begin
                    state <= 2; 
                end
            end
            default: begin
                state <= 0;
                in_reg <= 0;
                byte1 <= 0;
                byte2 <= 0;
                byte3 <= 0;
                out_bytes_reg <= 0;
                done <= 0;
            end
        endcase
    end
end

assign out_bytes = out_bytes_reg;
endmodule
