module top_module (
    input clk,
    input in,
    input reset,
    output [7:0] out_byte,
    output done
);

reg [2:0] state;
reg [7:0] byte;
reg start_bit;
reg stop_bit;
wire [7:0] out_byte;
wire done;

assign out_byte = done ? byte : 8'bzzzzzzzz;
assign done = stop_bit;

always @(posedge clk) begin
    if (reset) begin
        state <= 3'b000;
        byte <= 8'b0;
        start_bit <= 1'b0;
        stop_bit <= 1'b0;
    end else begin
        case (state)
            3'b000: begin // IDLE
                if (in == 1'b0) begin
                    state <= state + 1;
                    start_bit <= 1'b1;
                end
            end
            3'b001: begin // DATA
                if (in == 1'b0) begin
                    byte <= {in, byte[7:1]};
                end
                state <= state + 1;
            end
            3'b010: begin // STOP BIT
                if (in == 1'b1) begin
                    stop_bit <= 1'b1;
                    state <= state + 1;
                end else begin
                    state <= 3'b000;
                end
            end
            3'b011: begin // DONE
                state <= 3'b000;
            end
        endcase
    end
end

endmodule
