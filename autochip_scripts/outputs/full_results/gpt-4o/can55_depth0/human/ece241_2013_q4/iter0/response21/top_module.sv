module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

    reg [1:0] present_state, next_state;
    reg prev_water_level;

    // State encoding
    localparam LOW     = 2'b00;
    localparam MID_LOW = 2'b01;
    localparam MID_HIGH = 2'b10;
    localparam HIGH    = 2'b11;

    // State transition and output logic
    always @(*) begin
        // Default outputs
        fr3 = 0;
        fr2 = 0;
        fr1 = 0;
        dfr = 0;

        case (present_state)
            LOW: begin
                if (s == 3'b000) begin
                    fr3 = 1;
                    fr2 = 1;
                    fr1 = 1;
                end
                if (s == 3'b001) next_state = MID_LOW;
                else next_state = LOW;
            end

            MID_LOW: begin
                if (s == 3'b001) begin
                    fr2 = 1;
                    fr1 = 1;
                end
                if (s == 3'b011) next_state = MID_HIGH;
                else if (s == 3'b000) next_state = LOW;
                else next_state = MID_LOW;
            end

            MID_HIGH: begin
                fr1 = 1;
                if (s == 3'b011) begin
                    fr1 = 1;
                end
                if (s == 3'b111) next_state = HIGH;
                else if (s == 3'b001) next_state = MID_LOW;
                else next_state = MID_HIGH;
            end

            HIGH: begin
                if (s == 3'b111) begin
                    fr1 = 0;
                end
                if (s == 3'b011) next_state = MID_HIGH;
                else next_state = HIGH;
            end
        endcase

        // Determine dfr based on previous level
        if (present_state < next_state) begin
            dfr = 1;
        end

        // Set next_state to LOW if reset
        if (reset) begin
            next_state = LOW;
        end
    end

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            present_state <= LOW;
        end
        else begin
            present_state <= next_state;
        end
    end

endmodule
