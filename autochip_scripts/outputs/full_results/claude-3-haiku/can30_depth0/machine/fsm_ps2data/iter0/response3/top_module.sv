module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg [23:0] out_bytes,
    output reg done
);

// Define the states of the state machine
localparam BYTE1 = 2'b00, BYTE2 = 2'b01, BYTE3 = 2'b10, DONE = 2'b11;
reg [1:0] state, next_state;

// State transition logic
always @(*) begin
    case (state)
        BYTE1: begin
            if (in[2]) begin
                next_state = BYTE2;
            end else begin
                next_state = BYTE1;
            end
        end
        BYTE2: begin
            next_state = BYTE3;
        end
        BYTE3: begin
            next_state = DONE;
        end
        DONE: begin
            if (in[2]) begin
                next_state = BYTE1;
            end else begin
                next_state = DONE;
            end
        end
        default: begin
            next_state = BYTE1;
        end
    endcase
end

// State update logic
always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= BYTE1;
        out_bytes <= 24'b0;
        done <= 1'b0;
    end else begin
        state <= next_state;
        if (state == BYTE1) begin
            out_bytes <= {out_bytes[15:0], in};
        end else if (state == BYTE2) begin
            out_bytes <= {out_bytes[7:0], in, out_bytes[23:16]};
        end else if (state == BYTE3) begin
            out_bytes <= {in, out_bytes[23:8]};
        end
        done <= (state == DONE);
    end
end

endmodule
