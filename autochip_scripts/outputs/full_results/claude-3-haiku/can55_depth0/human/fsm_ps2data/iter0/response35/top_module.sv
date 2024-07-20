module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

localparam [1:0] SEARCH = 2'b00,
                 RECEIVE = 2'b01,
                 DONE = 2'b10;

reg [1:0] state, next_state;
reg [2:0] byte_count;

always @(posedge clk) begin
    if (reset) begin
        state <= SEARCH;
        byte_count <= 3'b0;
        out_bytes <= 24'b0;
        done <= 1'b0;
    end
    else begin
        state <= next_state;
        case (state)
            SEARCH: begin
                if (in[3]) begin
                    next_state <= RECEIVE;
                    byte_count <= 3'b001;
                    out_bytes[23:16] <= in;
                end
                else begin
                    next_state <= SEARCH;
                    byte_count <= 3'b0;
                    out_bytes <= 24'b0;
                end
            end
            RECEIVE: begin
                case (byte_count)
                    3'b001: begin
                        out_bytes[15:8] <= in;
                        byte_count <= 3'b010;
                        next_state <= RECEIVE;
                    end
                    3'b010: begin
                        out_bytes[7:0] <= in;
                        byte_count <= 3'b011;
                        next_state <= DONE;
                    end
                    3'b011: begin
                        done <= 1'b1;
                        next_state <= SEARCH;
                        byte_count <= 3'b000;
                    end
                    default: begin
                        next_state <= SEARCH;
                        byte_count <= 3'b000;
                    end
                endcase
            end
            DONE: begin
                done <= 1'b1;
                next_state <= SEARCH;
                byte_count <= 3'b000;
            end
            default: begin
                next_state <= SEARCH;
                byte_count <= 3'b000;
                out_bytes <= 24'b0;
                done <= 1'b0;
            end
        endcase
    end
end

endmodule
