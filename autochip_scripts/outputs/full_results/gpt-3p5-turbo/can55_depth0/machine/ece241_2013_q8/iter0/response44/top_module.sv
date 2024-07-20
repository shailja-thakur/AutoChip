module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // Define the state register
    reg [3:0] state;
    reg [3:0] next_state;

    // Assign initial state
    always @(posedge clk or negedge aresetn) begin
        if (~aresetn) begin
            state <= 4'b0000; // Initial state S
        end else begin
            state <= next_state; // Update state
        end
    end

    // Define the next state logic
    always @(*) begin
        case (state)
            4'b0000: begin // State S
                if (x == 1'b0) begin
                    next_state = 4'b0000; // Next state S
                end else if (x == 1'b1) begin
                    next_state = 4'b0001; // Next state S1
                end
            end
            4'b0001: begin // State S1
                if (x == 1'b0) begin
                    next_state = 4'b0010; // Next state S10
                end else if (x == 1'b1) begin
                    next_state = 4'b0001; // Next state S1
                end
            end
            4'b0010: begin // State S10
                if (x == 1'b0) begin
                    next_state = 4'b0000; // Next state S
                end else if (x == 1'b1) begin
                    next_state = 4'b0001; // Next state S1
                end
            end
            default: begin
                next_state = 4'b0000; // Default next state S
            end
        endcase
    end

    // Define the output logic
    always @(state) begin
        case (state)
            4'b0000, 4'b0001: begin // States S and S1
                z = 1'b0;
            end
            4'b0010: begin // State S10
                z = x;
            end
            default: begin
                z = 1'b0; // Default output 0
            end
        endcase
    end

endmodule
