module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

localparam SEARCH = 2'b00;
localparam ACCUMULATE = 2'b01;
localparam DONE = 2'b11;

reg [1:0] state;
reg [2:0] byte_count;

always @(posedge clk) begin
    if (reset) begin
        state <= SEARCH;
        byte_count <= 0;
        out_bytes <= 0;
        done <= 0;
    end
    else begin
        case (state)
            SEARCH: begin
                if (in[3]) begin
                    state <= ACCUMULATE;
                    byte_count <= 1;
                    out_bytes[23:16] <= in;
                end
            end
            ACCUMULATE: begin
                out_bytes[15:8] <= out_bytes[23:16];
                out_bytes[23:16] <= in;
                byte_count <= byte_count + 1;
                if (byte_count == 2) begin
                    state <= DONE;
                end
            end
            DONE: begin
                out_bytes[7:0] <= in;
                done <= 1;
                state <= SEARCH;
                byte_count <= 0;
            end
        endcase
    end
end

endmodule
