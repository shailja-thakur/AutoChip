module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);
    reg [2:0] state, next_state;

    // State encoding
    localparam S0 = 3'b000;
    localparam S1 = 3'b001;
    localparam S2 = 3'b010;
    localparam S3 = 3'b011;
    localparam S4 = 3'b100;

    // State transition logic
    always @ (posedge clk) begin
        if (reset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic and output logic
    always @ (*) begin
        case (state)
            S0: begin
                if (x) begin
                    next_state = S1;
                end else begin
                    next_state = S0;
                end
                z = 0;
            end
            S1: begin
                if (x) begin
                    next_state = S4;
                end else begin
                    next_state = S1;
                end
                z = 0;
            end
            S2: begin
                if (x) begin
                    next_state = S1;
                end else begin
                    next_state = S2;
                end
                z = 0;
            end
            S3: begin
                if (x) begin
                    next_state = S2;
                end else begin
                    next_state = S1;
                end
                z = 1;
            end
            S4: begin
                if (x) begin
                    next_state = S4;
                end else begin
                    next_state = S3;
                end
                z = 1;
            end
            default: begin
                next_state = S0;
                z = 0;
            end
        endcase
    end
endmodule
