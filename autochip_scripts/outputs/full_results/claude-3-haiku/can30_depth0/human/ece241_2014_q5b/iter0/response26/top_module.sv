module top_module (
    input clk,
    input areset,
    input x,
    output z
);

// Define the one-hot encoding for the states
localparam [1:0] STATE_A = 2'b01;
localparam [1:0] STATE_B = 2'b10;

// Internal signals
reg [1:0] current_state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= STATE_A;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        STATE_A: begin
            if (x) begin
                next_state = STATE_B;
                z = 1'b1;
            end
            else begin
                next_state = STATE_A;
                z = 1'b0;
            end
        end
        STATE_B: begin
            if (x) begin
                next_state = STATE_B;
                z = 1'b0;
            end
            else begin
                next_state = STATE_B;
                z = 1'b1;
            end
        end
        default: begin
            next_state = STATE_A;
            z = 1'b0;
        end
    endcase
end

endmodule
