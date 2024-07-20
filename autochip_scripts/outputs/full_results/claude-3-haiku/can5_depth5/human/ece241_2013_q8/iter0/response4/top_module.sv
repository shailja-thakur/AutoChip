module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

// Define the states of the Mealy FSM
parameter IDLE = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

// State register
reg [1:0] state, next_state;

always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case (state)
        IDLE: begin
            if (x) begin
                next_state = S1;
            end else begin
                next_state = IDLE;
            end
        end
        S1: begin
            if (x) begin
                next_state = S2;
            end else begin
                next_state = IDLE;
            end
        end
        S2: begin
            if (x) begin
                next_state = S3;
            end else begin
                next_state = IDLE;
            end
        end
        S3: begin
            if (x) begin
                next_state = S1;
            end else begin
                next_state = IDLE;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

// Output logic
always @(*) begin
    case (state)
        S3: begin
            z = 1'b1;
        end
        default: begin
            z = 1'b0;
        end
    endcase
end

endmodule
