module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);

    reg [2:0] state;
    wire shift_in;

    assign shift_in = in & ~reset;

    // Next state and output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
        end else begin
            case(state)
                // Check for bit to be discarded
                3'b000: begin
                    if (shift_in) begin
                        state <= 3'b001;
                        disc <= 1'b0;
                        flag <= 1'b0;
                        err <= 1'b0;
                    end else begin
                        state <= 3'b000;
                        disc <= 1'b0;
                        flag <= 1'b0;
                        err <= 1'b0;
                    end
                end
                // Look for flag
                3'b001: begin
                    if (shift_in) begin
                        state <= 3'b010;
                        disc <= 1'b0;
                        flag <= 1'b0;
                        err <= 1'b0;
                    end else begin
                        state <= 3'b000;
                        disc <= 1'b0;
                        flag <= 1'b0;
                        err <= 1'b0;
                    end
                end
                // Look for error
                3'b010: begin
                    if(shift_in) begin
                        state <= 3'b010;
                        disc <= 1'b0;
                        flag <= 1'b0;
                        err <= 1'b1;
                    end else begin
                        state <= 3'b011;
                        disc <= 1'b0;
                        flag <= 1'b0;
                        err <= 1'b0;
                    end
                end
                // Wait for flag to end
                3'b011: begin
                    if(shift_in) begin
                        state <= 3'b010;
                        disc <= 1'b0;
                        flag <= 1'b0;
                        err <= 1'b1;
                    end else begin
                        state <= 3'b100;
                        disc <= 1'b0;
                        flag <= 1'b1;
                        err <= 1'b0;
                    end
                end
                default: begin
                    state <= 3'b000;
                    disc <= 1'b0;
                    flag <= 1'b0;
                    err <= 1'b0;
                end
            endcase
        end
    end
endmodule
