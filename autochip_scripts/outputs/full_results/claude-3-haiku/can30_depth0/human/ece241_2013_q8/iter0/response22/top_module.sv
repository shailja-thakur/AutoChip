module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

// Define the three states of the FSM
localparam [1:0] IDLE = 2'b00, DETECT1 = 2'b01, DETECT101 = 2'b10;

// Declare the state register
reg [1:0] state;

always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
        // Asynchronous reset
        state <= IDLE;
        z <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (x) begin
                    state <= DETECT1;
                end
                else begin
                    state <= IDLE;
                end
                z <= 1'b0;
            end
            DETECT1: begin
                if (x) begin
                    state <= DETECT101;
                end
                else begin
                    state <= IDLE;
                end
                z <= 1'b0;
            end
            DETECT101: begin
                if (x) begin
                    state <= DETECT1;
                end
                else begin
                    state <= IDLE;
                end
                z <= 1'b1; // Detect the "101" sequence
            end
            default: begin
                state <= IDLE;
                z <= 1'b0;
            end
        endcase
    end
end

endmodule
