module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // Define states
    parameter S = 2'b00;
    parameter S1 = 2'b01;
    parameter S10 = 2'b10;

    // Define next states
    reg [1:0] state;
    reg [1:0] next_state;

    // Define state transitions based on input x and current state
    always @(posedge clk or negedge aresetn) begin
        if (~aresetn) begin
            state <= S;
        end else begin
            case (state)
                S: begin
                    if (x == 1'b1) begin
                        next_state <= S1;
                    end else begin
                        next_state <= S;
                    end
                end
                S1: begin
                    if (x == 1'b1) begin
                        next_state <= S1;
                    end else if (x == 1'b0) begin
                        next_state <= S10;
                    end
                end
                S10: begin
                    if (x == 1'b1) begin
                        next_state <= S1;
                    end else begin
                        next_state <= S;
                    end
                end
                default: next_state <= S;
            endcase
        end
    end

    // Assign output z based on current state
    always @(posedge clk or negedge aresetn) begin
        if (~aresetn) begin
            z <= 1'b0;
        end else begin
            case (state)
                S, S1: z <= 1'b0;
                S10: z <= x;
                default: z <= 1'b0;
            endcase
        end
    end

endmodule
