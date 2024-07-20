module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

reg [1:0] state;
reg [2:0] byte_count;

parameter IDLE = 2'b00;
parameter SEARCH = 2'b01;
parameter RECEIVE = 2'b10;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        byte_count <= 0;
        out_bytes <= 0;
        done <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in[3]) begin
                    state <= SEARCH;
                    byte_count <= 1;
                end
            end
            SEARCH: begin
                if (in[3]) begin
                    state <= RECEIVE;
                    byte_count <= 1;
                end
                else begin
                    byte_count <= 0;
                end
            end
            RECEIVE: begin
                out_bytes <= {out_bytes[15:0], in};
                byte_count <= byte_count + 1;
                if (byte_count == 3) begin
                    state <= IDLE;
                    done <= 1;
                end
                else begin
                    done <= 0;
                end
            end
        endcase
    end
end

endmodule
