module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

reg [23:0] out_reg;
reg [3:0] state;

parameter BYTE1 = 2'b00;
parameter BYTE2 = 2'b01;
parameter BYTE3 = 2'b10;
parameter DONE = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= BYTE1;
    else begin
        case (state)
            BYTE1: begin
                if (in[2] == 1'b1)
                    state <= BYTE2;
                else
                    state <= BYTE1;
            end
            
            BYTE2: begin
                if (in[2] == 1'b1)
                    state <= BYTE3;
                else
                    state <= BYTE1;
            end
            
            BYTE3: begin
                if (in[2] == 1'b1)
                    state <= DONE;
                else
                    state <= BYTE1;
            end
            
            DONE: begin
                if (in[2] == 1'b0)
                    state <= BYTE1;
                else
                    state <= DONE;
            end
        endcase
    end
end

always @(posedge clk) begin
    if (state == DONE)
        out_reg <= {in, out_reg[23:8]};
    else
        out_reg <= out_reg;
end

assign out_bytes = out_reg;
assign done = (state == DONE);

endmodule
