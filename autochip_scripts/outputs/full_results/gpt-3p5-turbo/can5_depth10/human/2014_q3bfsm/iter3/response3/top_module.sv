module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

// Define state enumeration
typedef enum logic [2:0] {
    S0, S1, S2, S3, S4
} state_t;

// Define state and next_state signals
reg [2:0] state;
reg [2:0] next_state;

// Reset logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= S0;
    end else begin
        state <= next_state;
    end
end

// State transition and output logic
always @(state, x) begin
    case (state)
        S0: begin
            if (x) begin
                next_state = S1;
                z = 1'b0;
            end else begin
                next_state = S0;
                z = 1'b0;
            end
        end

        S1: begin
            if (x) begin
                next_state = S4;
                z = 1'b0;
            end else begin
                next_state = S1;
                z = 1'b0;
            end
        end

        S2: begin
            if (x) begin
                next_state = S1;
                z = 1'b0;
            end else begin
                next_state = S2;
                z = 1'b0;
            end
        end

        S3: begin
            if (x) begin
                next_state = S2;
                z = 1'b1;
            end else begin
                next_state = S1;
                z = 1'b0;
            end
        end

        S4: begin
            if (x) begin
                next_state = S4;
                z = 1'b1;
            end else begin
                next_state = S3;
                z = 1'b1;
            end
        end
    endcase
end

endmodule
