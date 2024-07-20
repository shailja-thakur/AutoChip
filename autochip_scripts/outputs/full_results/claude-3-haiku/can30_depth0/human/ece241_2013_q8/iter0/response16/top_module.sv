module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

// Define the states
localparam STATE_IDLE = 2'b00;
localparam STATE_FIRST_1 = 2'b01;
localparam STATE_LAST_1 = 2'b11;

// Declare the state register
reg [1:0] state;

always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
        state <= STATE_IDLE;
        z <= 1'b0;
    end
    else begin
        case (state)
            STATE_IDLE: begin
                if (x == 1'b1) begin
                    state <= STATE_FIRST_1;
                    z <= 1'b0;
                end
                else begin
                    state <= STATE_IDLE;
                    z <= 1'b0;
                end
            end
            STATE_FIRST_1: begin
                if (x == 1'b0) begin
                    state <= STATE_LAST_1;
                    z <= 1'b0;
                end
                else begin
                    state <= STATE_FIRST_1;
                    z <= 1'b0;
                end
            end
            STATE_LAST_1: begin
                if (x == 1'b1) begin
                    state <= STATE_FIRST_1;
                    z <= 1'b1;
                end
                else begin
                    state <= STATE_IDLE;
                    z <= 1'b0;
                end
            end
            default: begin
                state <= STATE_IDLE;
                z <= 1'b0;
            end
        endcase
    end
end

endmodule
