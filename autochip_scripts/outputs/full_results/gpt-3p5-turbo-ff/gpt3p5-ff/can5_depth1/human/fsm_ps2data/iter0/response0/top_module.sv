module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

reg [1:0] state;
reg [7:0] byte1, byte2, byte3;

always @(posedge clk) begin
    if (reset) begin
        state <= 2'b00;
    end else begin
        case (state)
            2'b00: begin
                if (in[3]) begin
                    byte1 <= in;
                    state <= 2'b01;
                end 
            end

            2'b01: begin
                byte2 <= in;
                state <= 2'b10;
            end

            2'b10: begin
                byte3 <= in;
                state <= 2'b11;
            end
            
            2'b11: begin
                out_bytes <= {byte1, byte2, byte3};
                state <= 2'b00;
            end
        endcase
    end
end

always @(posedge clk) begin
    if (reset) begin
        done <= 0;
    end else begin
        done <= state == 2'b11;
    end
end

endmodule
