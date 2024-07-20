module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

localparam S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
reg [1:0] state, next_state;

// State transition logic
always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
        state <= S0;
    end else begin
        state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case (state)
        S0: begin
            if (x) begin
                next_state = S1;
            end else begin
                next_state = S0;
            end
        end
        S1: begin
            if (x) begin
                next_state = S2;
            end else begin
                next_state = S0;
            end
        end
        S2: begin
            if (x) begin
                next_state = S3;
            end else begin
                next_state = S0;
            end
        end
        S3: begin
            if (x) begin
                next_state = S1;
            end else begin
                next_state = S0;
            end
        end
        default: next_state = S0;
    endcase
end

// Output logic
always @(*) begin
    case (state)
        S3: z = 1'b1;
        default: z = 1'b0;
    endcase
end

endmodule
