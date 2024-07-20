module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

reg [1:0] state;
reg [2:0] count;

localparam SEARCH = 2'b00;
localparam RECEIVE = 2'b01;
localparam DONE = 2'b10;

always @(posedge clk) begin
    if (reset) begin
        state <= SEARCH;
        count <= 0;
        out_bytes <= 0;
        done <= 0;
    end
    else begin
        case (state)
            SEARCH: begin
                if (in[3]) begin
                    state <= RECEIVE;
                    count <= 1;
                    out_bytes[7:0] <= in;
                end
                else begin
                    state <= SEARCH;
                    count <= 0;
                    out_bytes <= 0;
                end
            end
            RECEIVE: begin
                count <= count + 1;
                case (count)
                    1: out_bytes[15:8] <= in;
                    2: out_bytes[23:16] <= in;
                endcase
                if (count == 2) begin
                    state <= DONE;
                    done <= 1;
                end
                else begin
                    state <= RECEIVE;
                    done <= 0;
                end
            end
            DONE: begin
                state <= SEARCH;
                count <= 0;
                done <= 0;
            end
        endcase
    end
end

endmodule
