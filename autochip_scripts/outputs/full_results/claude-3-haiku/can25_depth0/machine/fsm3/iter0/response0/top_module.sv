module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

// Define the state parameters
localparam [1:0] STATE_A = 2'b00, STATE_B = 2'b01, STATE_C = 2'b10, STATE_D = 2'b11;

// Define the state register
reg [1:0] state;

// State transition logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_A;
    end
    else begin
        case (state)
            STATE_A: begin
                if (in) begin
                    state <= STATE_B;
                end
                else begin
                    state <= STATE_A;
                end
            end
            STATE_B: begin
                if (in) begin
                    state <= STATE_B;
                end
                else begin
                    state <= STATE_C;
                end
            end
            STATE_C: begin
                if (in) begin
                    state <= STATE_D;
                end
                else begin
                    state <= STATE_A;
                end
            end
            STATE_D: begin
                if (in) begin
                    state <= STATE_B;
                end
                else begin
                    state <= STATE_C;
                end
            end
        endcase
    end
end

// Output logic
always @(*) begin
    out = (state == STATE_D);
end

endmodule
