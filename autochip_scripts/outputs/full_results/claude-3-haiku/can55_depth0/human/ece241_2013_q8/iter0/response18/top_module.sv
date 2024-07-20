module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

// Define the state encoding
localparam STATE_0 = 2'b00;
localparam STATE_1 = 2'b01;
localparam STATE_2 = 2'b11;

// Define the state register
reg [1:0] state, next_state;

// Mealy FSM logic
always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= STATE_0;
        z <= 1'b0;
    end
    else begin
        state <= next_state;
        case (state)
            STATE_0: begin
                if (x) begin
                    next_state <= STATE_1;
                    z <= 1'b0;
                end
                else begin
                    next_state <= STATE_0;
                    z <= 1'b0;
                end
            end
            STATE_1: begin
                if (x) begin
                    next_state <= STATE_2;
                    z <= 1'b0;
                end
                else begin
                    next_state <= STATE_0;
                    z <= 1'b0;
                end
            end
            STATE_2: begin
                if (x) begin
                    next_state <= STATE_1;
                    z <= 1'b1;
                end
                else begin
                    next_state <= STATE_0;
                    z <= 1'b0;
                end
            end
            default: begin
                next_state <= STATE_0;
                z <= 1'b0;
            end
        endcase
    end
end

endmodule
