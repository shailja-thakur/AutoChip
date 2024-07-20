module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err);

    reg [2:0] state, next_state;

    // State encoding
    localparam S0 = 3'b000;
    localparam S1 = 3'b001;
    localparam S2 = 3'b010;
    localparam S3 = 3'b011;
    localparam S4 = 3'b100;
    localparam S5 = 3'b101;
    localparam S6 = 3'b110;
    localparam S7 = 3'b111;

    // State transition logic
    always @(*) begin
        case (state)
            S0: next_state = in ? S1 : S0;
            S1: next_state = in ? S2 : S0;
            S2: next_state = in ? S3 : S0;
            S3: next_state = in ? S4 : S0;
            S4: next_state = in ? S5 : S0;
            S5: next_state = in ? S6 : S0;
            S6: next_state = in ? S7 : S0;
            S7: next_state = in ? S7 : S0;
            default: next_state = S0;
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
            disc <= 0;
            flag <= 0;
            err <= 0;
        end else begin
            state <= next_state;
            case (next_state)
                S0: begin
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
                S1: begin
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
                S2: begin
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
                S3: begin
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
                S4: begin
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
                S5: begin
                    disc <= 1;
                    flag <= 0;
                    err <= 0;
                end
                S6: begin
                    disc <= 0;
                    flag <= 1;
                    err <= 0;
                end
                S7: begin
                    disc <= 0;
                    flag <= 0;
                    err <= 1;
                end
                default: begin
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
            endcase
        end
    end
endmodule
