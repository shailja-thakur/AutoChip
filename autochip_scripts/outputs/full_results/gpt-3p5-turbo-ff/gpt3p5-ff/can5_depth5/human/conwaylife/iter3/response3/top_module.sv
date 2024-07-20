module top_module(
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q);

    reg [255:0] q_temp; // Declare q_temp outside always block

    always @(posedge clk) begin
        if (load) begin
            q <= data;
        end else begin
            q_temp <= q; // Assign value to q_temp

            for (integer i = 0; i < 256; i = i + 1) begin
                integer sum = 0;

                // Check neighbors...
                integer left_index = i - 1;
                if (i % 16 == 0) begin
                    left_index = i + 15; // Wrap around to right
                end
                sum = sum + q_temp[left_index];

                integer right_index = i + 1;
                if ((i + 1) % 16 == 0) begin
                    right_index = i - 15; // Wrap around to left
                end
                sum = sum + q_temp[right_index];

                sum = sum + q_temp[i - 16]; // Top
                sum = sum + q_temp[i + 16]; // Bottom

                integer top_left_index = i - 17;
                if (i >= 16 && i % 16 == 0) begin
                    top_left_index = i - 1; // Wrap around to top-right
                end
                if (i >= 16) begin
                    sum = sum + q_temp[top_left_index];
                end

                integer top_right_index = i - 15;
                if (i >= 16 && (i + 1) % 16 == 0) begin
                    top_right_index = i - 31; // Wrap around to top-left
                end
                if (i >= 16) begin
                    sum = sum + q_temp[top_right_index];
                end

                integer bottom_left_index = i + 15;
                if (i < 240 && i % 16 == 0) begin
                    bottom_left_index = i + 31; // Wrap around to bottom-right
                end
                if (i < 240) begin
                    sum = sum + q_temp[bottom_left_index];
                end

                integer bottom_right_index = i + 17;
                if (i < 240 && (i + 1) % 16 == 0) begin
                    bottom_right_index = i + 1; // Wrap around to bottom-left
                end
                if (i < 240) begin
                    sum = sum + q_temp[bottom_right_index];
                end

                // Update cell state...
                case(sum)
                    2: q[i] <= q_temp[i];
                    3: q[i] <= 1;
                    default: q[i] <= 0;
                endcase
            end
        end
    end
endmodule
