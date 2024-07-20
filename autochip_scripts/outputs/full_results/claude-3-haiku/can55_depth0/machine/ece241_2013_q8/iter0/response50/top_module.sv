module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= 'b00; // Initial state is S
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        'b00: begin // State S
            if (x == 1'b0) begin
                next_state = 'b00; // Next state is S
            end
            else begin
                next_state = 'b01; // Next state is S1
            end
        end
        'b01: begin // State S1
            if (x == 1'b0) begin
                next_state = 'b10; // Next state is S10
            end
            else begin
                next_state = 'b01; // Next state is S1
            end
        end
        'b10: begin // State S10
            if (x == 1'b0) begin
                next_state = 'b00; // Next state is S
            end
            else begin
                next_state = 'b01; // Next state is S1
            end
        end
        default: begin
            next_state = 'b00; // Default to state S
        end
    endcase
end

always @(*) begin
    case (state)
        'b00: begin // State S
            z = 1'b0;
        end
        'b01: begin // State S1
            z = 1'b0;
        end
        'b10: begin // State S10
            z = x;
        end
        default: begin
            z = 1'b0; // Default output is 0
        end
    endcase
end

endmodule
