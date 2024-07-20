module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

reg [1:0] state;
reg [1:0] state_next;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00;
        out_bytes <= 24'b0;
        done <= 0;
    end else begin
        state <= state_next;
    end
end

always @(*) begin
    state_next = state;
    case (state)
        2'b00: begin
            if (in[3] == 1) begin
                state_next = 2'b01;
            end
        end
        2'b01: state_next = 2'b10;
        2'b10: state_next = 2'b11;
        2'b11: state_next = 2'b00;
        default: state_next = 2'b00;
    endcase
end

always @(posedge clk) begin
    if (state == 2'b00 && state_next != 2'b00) begin
        out_bytes <= {in, out_bytes[23:8]};
    end else begin
        out_bytes <= out_bytes;
    end

    if (state == 2'b11 && state_next == 2'b00) begin
        done <= 1;
    end else begin
        done <= 0;
    end
end

endmodule
