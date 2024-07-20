module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

// States
localparam IDLE = 2'b00;
localparam SEARCH = 2'b01;
localparam RECEIVE = 2'b10;

reg [1:0] state;
reg [1:0] byte_count;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        byte_count <= 2'b00;
        out_bytes <= 24'b0;
        done <= 1'b0;
    end else begin
        case (state)
            IDLE: begin
                if (in[3]) begin
                    state <= SEARCH;
                    byte_count <= 2'b01;
                    out_bytes <= {8'b0, in};
                end
            end
            SEARCH: begin
                if (in[3]) begin
                    byte_count <= byte_count + 1'b1;
                    if (byte_count == 2'b10) begin
                        state <= RECEIVE;
                    end
                    out_bytes <= {out_bytes[15:0], in};
                end
            end
            RECEIVE: begin
                byte_count <= byte_count + 1'b1;
                if (byte_count == 2'b11) begin
                    state <= IDLE;
                    done <= 1'b1;
                end
                out_bytes <= {out_bytes[15:0], in};
            end
            default: begin
                state <= IDLE;
                byte_count <= 2'b00;
                out_bytes <= 24'b0;
                done <= 1'b0;
            end
        endcase
    end
end

endmodule
