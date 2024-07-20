module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

// State definitions
localparam [1:0] STATE_A = 2'b00;
localparam [1:0] STATE_B = 2'b01;
localparam [1:0] STATE_C = 2'b10;
localparam [1:0] STATE_D = 2'b11;

// State register
reg [1:0] state, next_state;

// Next state logic
always @(*) begin
    case (state)
        STATE_A: begin
            if (in == 1'b0) begin
                next_state = STATE_A;
            end else begin
                next_state = STATE_B;
            end
        end
        STATE_B: begin
            if (in == 1'b0) begin
                next_state = STATE_C;
            end else begin
                next_state = STATE_B;
            end
        end
        STATE_C: begin
            if (in == 1'b0) begin
                next_state = STATE_A;
            end else begin
                next_state = STATE_D;
            end
        end
        STATE_D: begin
            if (in == 1'b0) begin
                next_state = STATE_C;
            end else begin
                next_state = STATE_B;
            end
        end
        default: begin
            next_state = STATE_A;
        end
    endcase
end

// Output logic
always @(*) begin
    if (state == STATE_D) begin
        out = 1'b1;
    end else begin
        out = 1'b0;
    end
end

// State register update
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_A;
    end else begin
        state <= next_state;
    end
end

endmodule
