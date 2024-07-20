module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

localparam STATE_0 = 2'b00;
localparam STATE_1 = 2'b01;
localparam STATE_2 = 2'b11;

reg [1:0] state, next_state;

// State transition logic
always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= STATE_0;
    end else begin
        state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case (state)
        STATE_0: begin
            if (x == 1'b0) begin
                next_state = STATE_0;
            end else begin
                next_state = STATE_1;
            end
        end
        STATE_1: begin
            if (x == 1'b0) begin
                next_state = STATE_0;
            end else begin
                next_state = STATE_2;
            end
        end
        STATE_2: begin
            if (x == 1'b0) begin
                next_state = STATE_0;
            end else begin
                next_state = STATE_2;
            end
        end
        default: begin
            next_state = STATE_0;
        end
    endcase
end

// Output logic
always @(*) begin
    case (state)
        STATE_2: begin
            z = 1'b1;
        end
        default: begin
            z = 1'b0;
        end
    endcase
end

endmodule
