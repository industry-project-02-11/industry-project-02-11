package com.team11.backend.domain.recommendation.dto;

import com.team11.backend.domain.recommendation.entity.Recommendation;
import com.team11.backend.domain.resource.dto.ResourceDto;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.time.LocalDateTime;

public class RecommendationDto {

    @Getter
    @NoArgsConstructor
    @AllArgsConstructor
    @Builder
    public static class CreateRequest {
        private Long resourceId; // Resource의 ID를 받아서 연관관계 설정
        private String recommendationText;
        private Float expectedSaving;
        private String status;
    }

    @Getter
    @NoArgsConstructor
    @AllArgsConstructor
    @Builder
    public static class UpdateRequest {
        private String recommendationText;
        private Float expectedSaving;
        private String status;
    }

    @Getter
    @NoArgsConstructor
    @AllArgsConstructor
    @Builder
    public static class Response {
        private Long id;
        private Long resourceId; // Resource의 ID 반환
        private ResourceDto.Response resource; // Resource 상세 정보 추가
        private String recommendationText;
        private Float expectedSaving;
        private String status;
        private LocalDateTime createdAt;

        public static Response from(Recommendation recommendation) {
            return Response.builder()
                    .id(recommendation.getId())
                    .resourceId(recommendation.getResource() != null ? recommendation.getResource().getId() : null) // 연관된 Resource의 ID 사용
                    .resource(recommendation.getResource() != null ? ResourceDto.Response.from(recommendation.getResource()) : null) // Resource 상세 정보
                    .recommendationText(recommendation.getRecommendationText())
                    .expectedSaving(recommendation.getExpectedSaving())
                    .status(recommendation.getStatus())
                    .createdAt(recommendation.getCreatedAt())
                    .build();
        }
    }
}
