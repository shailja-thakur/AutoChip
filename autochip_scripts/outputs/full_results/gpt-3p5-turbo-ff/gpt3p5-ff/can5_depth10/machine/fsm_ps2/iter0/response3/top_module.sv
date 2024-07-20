module top_module (
    input clk,
    input [7:0] in,
    input reset,
    output reg done
);

reg [1:0] state;
reg [7:0] next_state;

// State definitions
parameter BYTE1 = 2'b00;
parameter BYTE2 = 2'b01;
parameter BYTE3 = 2'b10;
parameter DONE  = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= BYTE1;
    end else begin
        state <= next_state;
    end
end

always @(state or in) begin
    case (state)
        BYTE1: begin
            if (in[2]) begin
                next_state <= BYTE2;
            end else begin
                next_state <= BYTE1;
            end
        end
        BYTE2: begin
            next_state <= BYTE3;
        end
        BYTE3: begin
            next_state <= DONE;
        end
        DONE: begin
            if (in[2]) begin
                next_state <= BYTE2;
            end else begin
                next_state <= BYTE1;
            end
        end
    endcase
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        done <= 0;
    end else begin
        if (state == DONE) begin
            done <= 1;
        end else begin
            done <= 0;
        end
    end
end

endmodule
