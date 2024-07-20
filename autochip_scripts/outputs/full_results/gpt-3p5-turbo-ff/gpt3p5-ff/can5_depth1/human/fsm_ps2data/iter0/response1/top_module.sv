module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output [23:0] out_bytes,
    output done
);

reg [2:0] state;
reg [7:0] byte_counter;
reg [23:0] message;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 3'b000;
        byte_counter <= 8'd0;
        message <= 24'd0;
        out_bytes <= 24'd0;
        done <= 1'b0;
    end else begin
        case (state)
            3'b000: begin // Idle state
                if (in[3] == 1'b1) begin
                    state <= 3'b001;
                    byte_counter <= 8'd1;
                    message[23:16] <= in;
                end
            end
            3'b001: begin // Second byte state
                state <= 3'b010;
                byte_counter <= 8'd2;
                message[15:8] <= in;
            end
            3'b010: begin // Third byte state
                state <= 3'b011;
                byte_counter <= 8'd3;
                message[7:0] <= in;
            end
            3'b011: begin // Done state
                state <= 3'b000;
                byte_counter <= 8'd0;
                done <= 1'b1;
                out_bytes <= message;
            end
            default: begin
                state <= 3'b000;
                byte_counter <= 8'd0;
                message <= 24'd0;
                out_bytes <= 24'd0;
                done <= 1'b0;
            end
        endcase
    end
end

endmodule
